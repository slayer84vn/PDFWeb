using System.Collections.Generic;
using Gmap.Model;
using DevExpress.Web;
using System;
using Gmap.Code;
using System.Linq;

namespace Gmap {
    public partial class User : System.Web.UI.Page {

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

        protected void GridView_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e) {
            if(e.Parameters == "ResetPass") {
                string userName = GridView.GetRowValues(GridView.FocusedRowIndex, "UserName").ToString();
                using (CHXD_MapEntities entities = new CHXD_MapEntities())
                {
                    tblUser user = entities.tblUsers.SingleOrDefault(x => x.UserName == userName);
                    user.Pass = AuthHelper.GetMD5("123456");
                    entities.SaveChanges();
                }

                GridView.DataBind();
                throw new Exception("Reset thành công!");
            }
        }

        protected void GridView_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            e.NewValues["Pass"] = AuthHelper.GetMD5("123456");
        }

        protected void GridView_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
        {
            e.NewValues["IsLock"] = false;
        }
    }
}