using eRestoran.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services.Reports
{
    public interface IReportService
    {
        List<UplatePoKorisniku> ReportUplatePoKorisniku();
        List<PrometPoKorisniku> ReportPrometPoKorisniku();
        

    }
}
