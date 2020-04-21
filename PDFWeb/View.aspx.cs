using System.Collections.Generic;
using PDFWeb.Model;
using DevExpress.Web;
using System.IO;
using PDFWeb.Code;
using System.Linq;
using System.Web.UI;
using System;
using iText.Kernel.Pdf;
using iText.Kernel.Geom;
using iText.Layout;
using iText.Layout.Element;
using iText.Kernel.Font;

using iText.IO.Font.Constants;
using iText.Kernel.Pdf.Canvas;
using iText.IO.Font;
using iText.Layout.Properties;
using iText.Kernel.Pdf.Action;
using System.Net.Mail;
using System.Configuration;
using System.Net;

namespace PDFWeb
{
    public partial class View : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Redirect("~/Account/SignIn.aspx");
            }
            btnLock.Visible = Session["GroupID"].ToString() == "QL";
            btnClose.Visible = (Session["GroupID"].ToString() == "QL" || Session["GroupID"].ToString() == "AD");
        }

        const string BranchImageIcon = "people_people_16x16devav";
        const string TypeImageIcon = "print_tasklist_16x16devav";
        const string PDFImageIcon = "export_exporttopdf_16x16";
        protected void treeView_VirtualModeCreateChildren(object sender,
        TreeViewVirtualModeCreateChildrenEventArgs e)
        {

            List<TreeViewVirtualNode> children = new List<TreeViewVirtualNode>();
            using (PDFEntities entities = new PDFEntities())
            {
                if (Session["GroupID"].ToString() != "QL")
                {
                    if (e.NodeName == null)
                    {
                        AddTypeNode(entities, children, Session["BranchID"].ToString());
                    }
                    else
                    {
                        AddFileNode(entities, children, e.NodeName, false);
                    }
                }
                else
                {
                    if (e.NodeName == null)
                    {
                        AddBranchNode(entities, children);
                    }
                    else if (e.NodeName.Substring(0, 2) == "B_")
                    {
                        AddTypeNode(entities, children, e.NodeName.Substring(2));
                    }
                    else
                    {
                        AddFileNode(entities, children, e.NodeName);
                    }
                }
            }

            e.Children = children;
        }

        private void AddBranchNode(PDFEntities entities, List<TreeViewVirtualNode> children)
        {
            var branchs = entities.tblDM_Branch.Where(x => x.IsEnable == true);
            foreach (var branch in branchs)
            {
                TreeViewVirtualNode childNode = new TreeViewVirtualNode("B_" + branch.BranchID, branch.BranchName);
                childNode.IsLeaf = false;
                childNode.Image.IconID = BranchImageIcon;
                children.Add(childNode);
            }
        }

        private void AddTypeNode(PDFEntities entities, List<TreeViewVirtualNode> children, string branch)
        {
            var types = entities.tblPDF_FileData.Where(z => z.BranchID == branch).Select(x => x.TypeID).Distinct();
            foreach (var type in types)
            {
                TreeViewVirtualNode childNode = new TreeViewVirtualNode(branch + "_" + type, entities.tblDM_Type.Single(x => x.TypeID == type).TypeName);
                childNode.IsLeaf = false;
                childNode.Image.IconID = TypeImageIcon;
                children.Add(childNode);
            }
        }

        private void AddFileNode(PDFEntities entities, List<TreeViewVirtualNode> children, string branch_type, bool isQL = true)
        {
            string groupID = Session["GroupID"].ToString();
            //string type = branch_type.Substring(branch_type.IndexOf('_') + 1);
            //string branch = branch_type.Substring(0, branch_type.IndexOf('_'));
            var files = entities.tblPDF_FileData.Where(x => (x.BranchID + "_" + x.TypeID) == branch_type && (isQL || x.GroupAccess.Contains(groupID)) && x.IsClose == false).Select(x => new { ID = x.ID, FileName = x.FileName });
            foreach (var file in files)
            {
                TreeViewVirtualNode childNode = new TreeViewVirtualNode(file.ID.ToString(), file.FileName);
                childNode.IsLeaf = true;
                childNode.Image.IconID = PDFImageIcon;
                children.Add(childNode);
            }
        }

        protected void treeView_NodeClick(object source, TreeViewNodeEventArgs e)
        {
            if (((DevExpress.Web.TreeViewVirtualNode)e.Node).IsLeaf)
            {
                string embed = "<object data=\"{0}\" type=\"application/pdf\" width=\"100%\" height=\"450px\">";
                embed += "Nếu bạn không thể xem file, bạn có thể tải file tại <a href = \"{0}\">đây</a>";
                embed += " hoặc tải về <a target = \"_blank\" href = \"http://get.adobe.com/reader/\">Adobe PDF Reader</a> để xem file.";
                embed += "</object>";
                ltEmbed.Text = string.Format(embed, ResolveUrl("~/Files/" + e.Node.Name + ".pdf"));
                Session["FileID"] = Convert.ToInt32(e.Node.Name);
                BindIdeas(Convert.ToInt32(e.Node.Name));
                divContent.Visible = true;
            }
            else
            {
                ltEmbed.Text = "";
                Session["FileID"] = null;
                divContent.Visible = false;
            }
        }
        public void Show(string message)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "msg", "alert('" + message + "');", true);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (PDFEntities entities = new PDFEntities())
            {
                int fileID = Convert.ToInt32(Session["FileID"]);
                tblPDF_FileData file = entities.tblPDF_FileData.SingleOrDefault(x => x.ID == fileID);
                file.Idea = file.Idea + " - " + (Session["User"] as tblDM_User).UserName + " (" + DateTime.Now.ToString("dd/MM/yyyy hh:mm") + "): " + txtIdea.Text + "\n";
                //tblPDF_Idea idea = new tblPDF_Idea();
                //idea.FileID = Convert.ToInt32(Session["FileID"]);
                //idea.IdeaContent = txtIdea.Text;
                //idea.IdeaDate = DateTime.Now;
                //idea.IdeaUser = (Session["User"] as tblDM_User).UserName;
                //entities.tblPDF_Idea.Add(idea);
                entities.SaveChanges();
                BindIdeas(Convert.ToInt32(Session["FileID"]));
                txtIdea.Text = "";
            }
        }

        private void BindIdeas(int fileID)
        {
            
            using (PDFEntities entities = new PDFEntities())
            {
                tblPDF_FileData file = entities.tblPDF_FileData.SingleOrDefault(x => x.ID == fileID);
                txtIdeas.Text = file.Idea;
                if (txtIdeas.Text.EndsWith("\n"))
                {
                    txtIdeas.Text = txtIdeas.Text.Substring(0, txtIdeas.Text.Length - 1);
                }
                ConfigbtnLock(file.IsLock);
            }
        }

        private void ConfigbtnLock(bool isLock)
        {
            if (isLock)
            {
                btnLock.Text = "Mở khóa dữ liệu";
                btnLock.Image.IconID = "iconbuilder_security_unlock_svg_white_16x16";
            }
            else
            {
                btnLock.Text = "Khóa dữ liệu";
                btnLock.Image.IconID = "outlookinspired_private_svg_white_16x16";
            }
            txtIdea.Enabled = btnSave.Enabled =  !isLock;
        }

        protected void btnLock_Click(object sender, EventArgs e)
        {
            int fileID = Convert.ToInt32(Session["FileID"]);
            using (PDFEntities entities = new PDFEntities())
            {
                tblPDF_FileData file = entities.tblPDF_FileData.SingleOrDefault(x => x.ID == fileID);
                file.IsLock = !file.IsLock;
                file.LockDate = DateTime.Today;
                file.LockUser = (Session["User"] as tblDM_User).UserName;
                entities.SaveChanges();
                ConfigbtnLock(file.IsLock);
            }
        }

        protected void btnPrintIdea_Click(object sender, EventArgs e)
        {
            int fileID = Convert.ToInt32(Session["FileID"]);
            string filePath = Server.MapPath("Files/" + Session["FileID"] + "_YKien.pdf");
            tblPDF_FileData file = null;
            string branchName = "";
            string typeName = "";
            using (PDFEntities entities = new PDFEntities())
            {
                file = entities.tblPDF_FileData.SingleOrDefault(x => x.ID == fileID);
                branchName = entities.tblDM_Branch.SingleOrDefault(x => x.BranchID == file.BranchID).BranchName;
                typeName = entities.tblDM_Type.SingleOrDefault(x => x.TypeID == file.TypeID).TypeName;
            }

            PdfDocument pdfDoc = new PdfDocument(new PdfWriter(filePath));
            Document doc = new Document(pdfDoc);

            Table table = new Table(UnitValue.CreatePercentArray(2)).UseAllAvailableWidth();
            PdfFont font = PdfFontFactory.CreateFont(Environment.GetEnvironmentVariable("windir") + @"\fonts\ARIAL.TTF", PdfEncodings.IDENTITY_H, true);
            table.SetFont(font);
            // The complete cell is a link:
            Cell cell11 = new Cell().Add(new Paragraph("Tên tệp: "));
            cell11.SetWidth(UnitValue.CreatePercentValue(30));
            table.AddCell(cell11);
            Cell cell12 = new Cell().Add(new Paragraph(file.FileName));
            cell12.SetWidth(UnitValue.CreatePercentValue(70));
            table.AddCell(cell12);

            Cell cell21 = new Cell().Add(new Paragraph("Đơn vị: "));
            cell21.SetWidth(UnitValue.CreatePercentValue(30));
            table.AddCell(cell21);
            Cell cell22 = new Cell().Add(new Paragraph(branchName));
            cell22.SetWidth(UnitValue.CreatePercentValue(70));
            table.AddCell(cell22);

            Cell cell31 = new Cell().Add(new Paragraph("Loại dữ liệu: "));
            cell31.SetWidth(UnitValue.CreatePercentValue(30));
            table.AddCell(cell31);
            Cell cell32 = new Cell().Add(new Paragraph(typeName));
            cell32.SetWidth(UnitValue.CreatePercentValue(70));
            table.AddCell(cell32);

            Cell cell41 = new Cell().Add(new Paragraph("Ngày cập nhật: "));
            cell41.SetWidth(UnitValue.CreatePercentValue(30));
            table.AddCell(cell41);
            Cell cell42 = new Cell().Add(new Paragraph(file.UpdatedDate.ToShortDateString()));
            cell42.SetWidth(UnitValue.CreatePercentValue(70));
            table.AddCell(cell42);

            Cell cell51 = new Cell().Add(new Paragraph("Người cập nhật: "));
            cell51.SetWidth(UnitValue.CreatePercentValue(30));
            table.AddCell(cell51);
            Cell cell52 = new Cell().Add(new Paragraph(file.UpdatedUser));
            cell52.SetWidth(UnitValue.CreatePercentValue(70));
            table.AddCell(cell52);


            Cell cell61 = new Cell().Add(new Paragraph("Các ý kiến: "));
            cell61.SetWidth(UnitValue.CreatePercentValue(30));
            table.AddCell(cell61);
            Cell cell62 = new Cell().Add(new Paragraph(file.Idea));
            cell62.SetWidth(UnitValue.CreatePercentValue(70));
            table.AddCell(cell62);

            doc.Add(table);
            doc.Close();

            Response.ContentType = "Application/pdf";
            Response.AppendHeader("content-disposition",
                    "attachment; filename=YKien.pdf");
            Response.WriteFile(filePath);
            Response.End();

        }


        protected void btnPrintAll_Click(object sender, EventArgs e)
        {
            int fileID = Convert.ToInt32(Session["FileID"]);
            string filePath = Server.MapPath("Files/" + Session["FileID"] + ".pdf");
            string tempPath = filePath.Replace(".pdf", "_" + Session["UserName"] + ".pdf");
            File.Copy(filePath, tempPath, true);
            if (txtIdeas.Text.Length > 0)
            {
                PdfDocument pdf = new PdfDocument(new PdfReader(filePath), new PdfWriter(tempPath));
                int index = pdf.GetNumberOfPages();
                PageSize ps = new PageSize(pdf.GetFirstPage().GetPageSize());
                PdfPage page = pdf.AddNewPage(index + 1, ps);
                PdfCanvas canvas = new PdfCanvas(page);

                string text = txtIdeas.Text;

                //PdfFont font = PdfFontFactory.CreateFont(StandardFonts.TIMES_ROMAN);
                //PdfFont bold = PdfFontFactory.CreateFont(StandardFonts.TIMES_BOLD);
                //Paragraph p = new Paragraph().Add(text);
                PdfFont font = PdfFontFactory.CreateFont(Environment.GetEnvironmentVariable("windir") + @"\fonts\ARIAL.TTF", PdfEncodings.IDENTITY_H, true);

                int size = Convert.ToInt32(Math.Round(ps.GetWidth() / 600)) * 12;
                float leading = size * 1.2f;
                canvas.ConcatMatrix(1, 0, 0, 1, 0, ps.GetHeight());
                canvas.BeginText().SetFontAndSize(font, size).SetLeading(leading).MoveText(70, -40);
                canvas.NewlineShowText("Danh sách các ý kiến: ");
                foreach (var item in text.Split(new string[1] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries))
                {
                    canvas.NewlineShowText(item);
                }
                canvas.EndText();
                pdf.Close();

                using (PDFEntities entities = new PDFEntities())
                {
                    tblPDF_FileData file = entities.tblPDF_FileData.SingleOrDefault(x => x.ID == fileID);
                    Response.ContentType = "Application/pdf";
                    Response.AppendHeader("content-disposition",
                            "attachment; filename=" + file.FileName);
                    Response.WriteFile(tempPath);
                    Response.End();
                }

            }

        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            int fileID = Convert.ToInt32(Session["FileID"]);
            using (PDFEntities entities = new PDFEntities())
            {
                tblPDF_FileData file = entities.tblPDF_FileData.SingleOrDefault(x => x.ID == fileID);
                file.IsClose = true;
                file.CloseDate = DateTime.Today;
                file.CLoseUser = (Session["User"] as tblDM_User).UserName;
                entities.SaveChanges();
            }
            treeView.RefreshVirtualTree();
            ltEmbed.Text = "";
            Session["FileID"] = null;
            divContent.Visible = false;
        }
        protected void btnSendMail_Click(object sender, EventArgs e)
        {

            MailAddress fromAddress = new MailAddress(ConfigurationManager.AppSettings["User"].ToString(), "Thông báo khu vực V");
            string fromPassword = ConfigurationManager.AppSettings["Password"].ToString();
            string host = ConfigurationManager.AppSettings["MailServer"].ToString();
            int port = Convert.ToInt32(ConfigurationManager.AppSettings["Port"]);

            List<MailAddress> listMail = new List<MailAddress>();
            string[] mails = txtMailAddress.Value.ToString().Split(',');
            foreach (string item in mails)
            {
                listMail.Add(new MailAddress(item));
            }
            
            string subject = "";
            string body = "";
            int fileID = Convert.ToInt32(Session["FileID"]);
            using (PDFEntities entities = new PDFEntities())
            {
                tblPDF_FileData file = entities.tblPDF_FileData.SingleOrDefault(x => x.ID == fileID);
                string branchName = entities.tblDM_Branch.SingleOrDefault(z => z.BranchID == file.BranchID).BranchName;
                subject = "Thông báo tài liệu: " + branchName;
                body = "Có thông báo từ văn bản " + branchName + "\\" + entities.tblDM_Type.SingleOrDefault(x => x.TypeID == file.TypeID).TypeName + "\\" + file.FileName + " - Ngày: " + DateTime.Now.ToString("dd/MM/yyy hh:mm")
                     + "<br/> Nội dung tóm tắt: " + file.ShortContent
                     + "<br/> Địa chỉ truy cập: " + Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/") + 1);
            }

            var smtp = new SmtpClient
            {
                Host = host,
                Port = port,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromAddress.Address, fromPassword)
            };
            using (var message = new MailMessage()
            {
                From = fromAddress,
                Subject = subject,
                Body = body,
                IsBodyHtml = true
            })
            {
                try
                {
                    foreach (var item in listMail)
                    {
                        message.To.Add(item);
                    }
                    smtp.Send(message);
                    Show("Gửi mail thành công!");
                }
                catch (Exception ex)
                {

                }

            }
        }
    }
}