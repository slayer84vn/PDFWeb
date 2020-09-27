using System.Collections.Generic;
using Gmap.Model;
using DevExpress.Web;
using System;
using Gmap.Code;
using System.Linq;

namespace Gmap {
    public partial class Update : System.Web.UI.Page {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            if (Session["GroupID"].ToString() != "A")
            {
                Response.Redirect("DeniedPage.aspx");
            }
        }

        protected void GridView_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
        {
            e.NewValues["Type"] = "H";
            e.NewValues["Status"] = "A";
        }

        protected void EntityDataSourceData_Updating(object sender, System.Web.UI.WebControls.EntityDataSourceChangingEventArgs e)
        {
            var entity = e.Entity as tblData;
            entity.UpdateDate = DateTime.Today;
            entity.UpdateUser = Session["UserName"].ToString();
        }

        protected void EntityDataSourceData_Inserting(object sender, System.Web.UI.WebControls.EntityDataSourceChangingEventArgs e)
        {
            var entity = e.Entity as tblData;
            entity.UpdateDate = DateTime.Today;
            entity.UpdateUser = Session["UserName"].ToString();
        }
    }
}