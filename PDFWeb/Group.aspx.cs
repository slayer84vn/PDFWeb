using System.Collections.Generic;
using PDFWeb.Model;
using DevExpress.Web;
using System;

namespace PDFWeb {
    public partial class Group : System.Web.UI.Page {

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
            if(e.Parameters == "delete") {
                List<long> selectedIds = GridView.GetSelectedFieldValues("Id").ConvertAll(id => (long)id);
                DataProvider.DeleteIssues(selectedIds);
                GridView.DataBind();
            }
        }

        protected void GridView_CellEditorInitialize(object sender, ASPxGridViewEditorEventArgs e)
        {
            if (GridView.IsEditing && !GridView.IsNewRowEditing && e.Column.FieldName == "GroupID")
            {
                e.Editor.ReadOnly = true;
            }
        }
    }
}