using System.Collections.Generic;
using PDFWeb.Model;
using DevExpress.Web;
using System;
using PDFWeb.Code;
using System.Linq;
using System.Web.UI;

namespace PDFWeb
{
    public partial class Report : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Redirect("~/Account/SignIn.aspx");
            }
            if (!Page.IsPostBack)
            {
                if (Session["GroupID"].ToString().Equals("QL"))
                {
                    cbbBranch.Enabled = true;
                }
                else
                {
                    cbbBranch.Enabled = false;
                    cbbBranch.Value = Session["BranchID"].ToString();
                }
            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            GridView.ExportXlsxToResponse("Report");
        }
    }
}