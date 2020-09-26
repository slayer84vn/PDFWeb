using System.Collections.Generic;
using PDFWeb.Model;
using DevExpress.Web;
using System;

namespace PDFWeb {
    public partial class ContactView : System.Web.UI.Page {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Page.Master.FindControl("HeaderPanel").Visible = false;
                Page.Master.FindControl("footerWrapper").Visible = false;
            }
        }

    }
}