using System.Collections.Generic;
using Gmap.Model;
using DevExpress.Web;
using System;
using Gmap.Code;
using System.Linq;

namespace Gmap {
    public partial class Data : System.Web.UI.Page {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Redirect("~/SignIn.aspx");
            }
        }
       
    }
}