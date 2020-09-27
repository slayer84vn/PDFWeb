using DevExpress.Web;
using DevExpress.Web.Rendering;
using Gmap.Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Gmap
{
    public partial class Map : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !IsCallback)
            {
                using (CHXD_MapEntities entities = new CHXD_MapEntities())
                {
                    var listData = entities.tblDatas.Where(x => x.Status == "A" && x.Type == "H").ToList();
                    foreach (var item in listData)
                    {
                        item.SummaryInfo = item.SummaryInfo.Replace("\n", "<br />");
                    }
                    string data = JsonSerializer.Serialize(listData);
                    hidPDF.Set("Data", data);
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "pdf", "loadMap();", true);

                }

            }

        }
        protected void cpPDF_Callback(object sender, CallbackEventArgsBase e)
        {
            using (CHXD_MapEntities entities = new CHXD_MapEntities())
            {
                var listData = entities.tblDatas.Where(x => x.Status == "A" && (x.Type == e.Parameter || e.Parameter == "A")).ToList();
                foreach (var item in listData)
                {
                    item.SummaryInfo = item.SummaryInfo.Replace("\\n", "<br />");
                }
                string data = JsonSerializer.Serialize(listData);
                hidPDF.Set("Data", data);
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "pdf", "loadMap();", true);

            }
        }
    }
}