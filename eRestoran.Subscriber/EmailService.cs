using System;
using System.Net.Mail;
using System.Net;
using Newtonsoft.Json;

namespace eRestoran.Subscriber
{
    public class EmailService
    {
        public class EmailModelToParse
        {
            public string? Sender { get; set; }
            public string? Recipient { get; set; }
            public string? Subject { get; set; }
            public string? Content { get; set; }
        }

        public void SendEmail(string message)
        {
            try
            {
                // Dobavljanje SMTP podataka iz environment varijabli
                string smtpServer = Environment.GetEnvironmentVariable("SMTP_SERVER") ?? "smtp.outlook.com";
                int smtpPort = int.TryParse(Environment.GetEnvironmentVariable("SMTP_PORT"), out int port) ? port : 587;
                string fromMail = Environment.GetEnvironmentVariable("SMTP_USERNAME");
                string password = Environment.GetEnvironmentVariable("SMTP_PASSWORD");

                if (string.IsNullOrEmpty(fromMail) || string.IsNullOrEmpty(password))
                {
                    Console.WriteLine("Error: SMTP credentials are missing.");
                    return;
                }

                var emailData = JsonConvert.DeserializeObject<EmailModelToParse>(message);
                if (emailData == null)
                {
                    Console.WriteLine("Error: Email message could not be parsed.");
                    return;
                }

                string senderEmail = emailData.Sender ?? fromMail;
                string recipientEmail = emailData.Recipient ?? "";
                string subject = emailData.Subject ?? "No Subject";
                string content = emailData.Content ?? "";

                if (string.IsNullOrWhiteSpace(recipientEmail))
                {
                    Console.WriteLine("Error: Recipient email is missing.");
                    return;
                }

                MailMessage mailMessageObj = new MailMessage
                {
                    From = new MailAddress(senderEmail),
                    Subject = subject,
                    Body = content
                };

                mailMessageObj.To.Add(recipientEmail);

                using var smtpClient = new SmtpClient(smtpServer, smtpPort)
                {
                    Credentials = new NetworkCredential(fromMail, password),
                    EnableSsl = true
                };

                smtpClient.Send(mailMessageObj);
                Console.WriteLine($"Email successfully sent to {recipientEmail}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error sending email: {ex.Message}");
            }
        }
    }
}
