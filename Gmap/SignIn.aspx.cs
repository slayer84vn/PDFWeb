﻿using System;
using DevExpress.Web;
using Gmap.Model;

namespace PDFWeb {
    public partial class SignInModule : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (!IsPostBack)
            {
                Page.Master.FindControl("HeaderPanel").Visible = false;
                Page.Master.FindControl("footerWrapper").Visible = false;
            }
            
        }

        protected void SignInButton_Click(object sender, EventArgs e) {
            FormLayout.FindItemOrGroupByName("GeneralError").Visible = false;
            if(ASPxEdit.ValidateEditorsInContainer(this, "login")) {
                // DXCOMMENT: You Authentication logic
                if (AuthHelper.SignIn(UserNameTextBox.Text, PasswordButtonEdit.Text) == null)
                {
                    GeneralErrorDiv.InnerText = "Đăng nhập không thành công: Sai tên đăng nhập hoặc mật khẩu.";
                    FormLayout.FindItemOrGroupByName("GeneralError").Visible = true;
                }
                else
                {
                    Response.Redirect("~/Map.aspx");

                }
            }
        }
    }
}