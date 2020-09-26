using System.Collections.Generic;
using PDFWeb.Model;
using DevExpress.Web;
using System;
using PDFWeb.Code;
using System.Linq;

namespace PDFWeb {
    public partial class User : System.Web.UI.Page {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Redirect("~/Account/SignIn.aspx");
            }
            if (Session["GroupID"].ToString() != "QL")
            {
                Response.Redirect("DeniedPage.aspx");
            }
        }

        protected void GridView_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e) {
            if(e.Parameters == "ResetPass") {
                string userName = GridView.GetRowValues(GridView.FocusedRowIndex, "UserName").ToString();
                using (PDFEntities entities = new PDFEntities())
                {
                    tblDM_User user = entities.tblDM_User.SingleOrDefault(x => x.UserName == userName);
                    user.Pass = AuthHelper.GetMD5("123456");
                    entities.SaveChanges();
                }

                GridView.DataBind();
                throw new Exception("Reset thành công!");
            }
        }

        protected void TypeDataSource_Selecting(object sender, DevExpress.Data.Linq.LinqServerModeDataSourceSelectEventArgs e)
        {
            e.KeyExpression = "UserName";
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