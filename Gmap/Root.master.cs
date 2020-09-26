using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using PDFWeb.Model;
using DevExpress.Web;
using PDFWeb.Code;
using System.Linq;
using System.Configuration;

namespace PDFWeb {
    public partial class Root : MasterPage {
        public bool EnableBackButton { get; set; }
        protected void Page_Load(object sender, EventArgs e) {
            if(!string.IsNullOrEmpty(Page.Header.Title))
                Page.Header.Title += " - ";
            Page.Header.Title = Page.Header.Title + "PDF FILE MANAGEMENT";
            Page.Header.DataBind();
            //UpdateUserMenuItemsVisible();
            HideUnusedContent();
            if (Session["GroupID"] != null)
            {
                ApplicationMenu.Items[3].Visible = Session["GroupID"].ToString() == "QL";
            }
            UpdateUserInfo();

        }

        protected void HideUnusedContent() {
            LeftAreaMenu.Items[1].Visible = EnableBackButton;

            bool hasLeftPanelContent = HasContent(LeftPanelContent);
            LeftAreaMenu.Items.FindByName("ToggleLeftPanel").Visible = hasLeftPanelContent;
            LeftPanel.Visible = hasLeftPanelContent;

            LeftAreaMenu.Items[3].Text = ConfigurationManager.AppSettings["Title"].ToString();
            //bool hasRightPanelContent = HasContent(RightPanelContent);
            //RightAreaMenu.Items.FindByName("ToggleRightPanel").Visible = hasRightPanelContent;
            //RightPanel.Visible = hasRightPanelContent;

            bool hasPageToolbar = HasContent(PageToolbar);
            PageToolbarPanel.Visible = hasPageToolbar;
        }

        protected bool HasContent(Control contentPlaceHolder) {
            if(contentPlaceHolder == null) return false;

            ControlCollection childControls = contentPlaceHolder.Controls;
            if(childControls.Count == 0) return false;

            return true;
        }

        // SignIn/Register

        protected void UpdateUserMenuItemsVisible() {
            //var isAuthenticated = AuthHelper.IsAuthenticated();
            //RightAreaMenu.Items.FindByName("SignInItem").Visible = !isAuthenticated;
            //RightAreaMenu.Items.FindByName("RegisterItem").Visible = !isAuthenticated;
            //RightAreaMenu.Items.FindByName("MyAccountItem").Visible = isAuthenticated;
            //RightAreaMenu.Items.FindByName("SignOutItem").Visible = isAuthenticated;
        }

        protected void UpdateUserInfo() {
            if(AuthHelper.IsAuthenticated()) {
                var user = AuthHelper.GetLoggedInUserInfo();
                var myAccountItem = RightAreaMenu.Items.FindByName("MyAccountItem");
                var userName = (ASPxLabel)myAccountItem.FindControl("UserNameLabel");
                userName.Text = user.UserName + " - Nhóm: " + user.GroupID;

            }
        }

        protected void RightAreaMenu_ItemClick(object source, DevExpress.Web.MenuItemEventArgs e) {
            if(e.Item.Name == "SignOutItem") {
                AuthHelper.SignOut(); // DXCOMMENT: Your Signing out logic
                Response.Redirect("~/Account/SignIn.aspx");
            }
            else if (e.Item.Name == "ChangePassItem")
            {
                popChangePass.ShowOnPageLoad = true;
            }
        }

        protected void ApplicationMenu_ItemDataBound(object source, MenuItemEventArgs e) {
            e.Item.Image.Url = string.Format("Content/Images/{0}.svg", e.Item.Text);
            e.Item.Image.UrlSelected = string.Format("Content/Images/{0}-white.svg", e.Item.Text);
        }
        public void Show(string message)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "msg", "alert('" + message + "');", true);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (txtPass1.Text != txtPass2.Text)
            {
                Show("Mật khẩu mới và nhập lại mật khẩu không khớp");
                return;
            }

            tblDM_User user = Session["User"] as tblDM_User;
            using (PDFEntities entities = new PDFEntities())
            {
                tblDM_User UserUpdate = entities.tblDM_User.SingleOrDefault(x => x.UserName == user.UserName);
                UserUpdate.Pass = AuthHelper.GetMD5(txtPass1.Text);
                entities.SaveChanges();

            }

            Show("Đổi mật khẩu thành công!");
            popChangePass.ShowOnPageLoad = false;
        }
    }
}