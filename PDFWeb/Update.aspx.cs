using System.Collections.Generic;
using PDFWeb.Model;
using DevExpress.Web;
using System;
using PDFWeb.Code;
using System.Linq;
using System.Web.UI;

namespace PDFWeb
{
    public partial class Update : System.Web.UI.Page
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
                    cbbBranch.ReadOnly = false;
                }
                else
                {
                    cbbBranch.ReadOnly = true;
                    cbbBranch.Value = Session["BranchID"].ToString();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            
            tblPDF_FileData file = null;
            tblDM_User user = Session["User"] as tblDM_User;
            using (PDFEntities entities = new PDFEntities())
            {
                if (Session["FileID"] == null)
                {
                    file = new tblPDF_FileData();
                }
                else
                {
                    int fileID = Convert.ToInt32(Session["FileID"]);
                    file = entities.tblPDF_FileData.SingleOrDefault(x => x.ID == fileID);
                }
                if (txtFile.UploadedFiles[0].FileName == "")
                {
                    if (Session["FileID"] == null)
                    {
                        Show("Bạn phải chọn file pdf!");
                        return;
                    }
                    
                }
                else
                {
                    file.FileName = txtFile.UploadedFiles[0].FileName;
                }
                
                file.BranchID = cbbBranch.Value.ToString();
                file.TypeID = cbbType.Value.ToString();
                file.ShortContent = txtShortContent.Text;
                file.GroupAccess = txtNhom.Value.ToString();
                file.UpdatedUser = user.UserName;
                file.UpdatedDate = DateTime.Today;
                file.IsLock = false;
                file.IsClose = false;
                if (file.ID == 0)
                {
                    entities.tblPDF_FileData.Add(file);
                }
                entities.SaveChanges();
                if (txtFile.UploadedFiles[0].FileName != "")
                {
                    txtFile.UploadedFiles[0].SaveAs(Server.MapPath("~/Files") + "\\" + file.ID + ".pdf");
                }
            }

            //
            ResetForm();
            popFile.ShowOnPageLoad = false;
            GridView.DataBind();

        }

        private void ResetForm()
        {
            cbbBranch.SelectedIndex = cbbType.SelectedIndex = -1;
            txtNhom.Value = Session["GroupID"].ToString();
            txtShortContent.Text = "";
            Session["FileID"] = null;

        }

        public void Show(string message)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "msg", "alert('" + message + "');", true);
        }

        protected void GridView_StartRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e)
        {
            int fileID = Convert.ToInt32(e.EditingKeyValue);
            Session["FileID"] = fileID;
            using (PDFEntities entities = new PDFEntities())
            {
                tblPDF_FileData file = entities.tblPDF_FileData.SingleOrDefault(x => x.ID == fileID);
                if (file.IsLock || file.IsClose)
                {
                    Show("File PDF đã khóa hoặc đóng, không thể chỉnh sửa!");
                    e.Cancel = true;
                    return;
                }

                if (Session["GroupID"].ToString() != "QL" && Session["UserName"].ToString() != file.UpdatedUser)
                {
                    Show("Bạn không phải người cập nhật hoặc không thuộc nhóm quản lý nên không thể chỉnh sửa!");
                    e.Cancel = true;
                    return;
                }
                BindData(file);
                popFile.ShowOnPageLoad = true;
                e.Cancel = true;
            }
        }
        private void BindData(tblPDF_FileData file)
        {
            cbbBranch.Value = file.BranchID;
            cbbType.Value = file.TypeID;
            txtNhom.Value = file.GroupAccess;
            txtShortContent.Text = file.ShortContent;
            cbbType.IsValid = txtNhom.IsValid = txtShortContent.IsValid = true;

        }

        protected void GridView_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int key = Convert.ToInt32(e.Keys[0]);
            using (PDFEntities entities = new PDFEntities())
            {
                tblPDF_FileData file = entities.tblPDF_FileData.SingleOrDefault(x => x.ID == key);
                if (file.IsLock || file.IsClose)
                {
                    e.Cancel = true;
                    Show("File PDF đã khóa hoặc đóng, không thể xóa!");
                    
                }
                else if (Session["GroupID"].ToString() != "QL" && Session["UserName"].ToString() != file.UpdatedUser)
                {
                    e.Cancel = true;
                    Show("Bạn không phải người cập nhật hoặc không thuộc nhóm quản lý nên không thể xóa!");
                   
                }
            }
        }

    }
}