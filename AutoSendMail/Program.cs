using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Net;
using System.Net.Mail;

namespace AutoSendMail
{
    class Program
    {
        static void Main(string[] args)
        {
            DataTable dtThongBao = ReadThongBao();
            if (dtThongBao.Rows.Count == 0)
            {
                return;
            }
            MailAddress fromAddress = new MailAddress(ConfigurationManager.AppSettings["User"].ToString(), "Thông báo khu vực V");
            string fromPassword = ConfigurationManager.AppSettings["Password"].ToString();
            string host = ConfigurationManager.AppSettings["MailServer"].ToString();
            int port = Convert.ToInt32(ConfigurationManager.AppSettings["Port"]);
            int isTest = Convert.ToInt32(ConfigurationManager.AppSettings["IsTest"]);
            foreach (DataRow dr in dtThongBao.Rows)
            {
                MailAddress toAddress = null;
                if (isTest == 1)
                {
                    toAddress = new MailAddress(ConfigurationManager.AppSettings["User"].ToString());
                }
                else
                {
                    toAddress = new MailAddress(dr["MAIL"].ToString());
                }
                string noidung = dr["NOI_DUNG"].ToString();
                string subject = noidung.Substring(0, 20);
                string body = noidung;

                var smtp = new SmtpClient
                {
                    Host = host,
                    Port = port,
                    EnableSsl = true,
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    UseDefaultCredentials = false,
                    Credentials = new NetworkCredential(fromAddress.Address, fromPassword)
                };
                using (var message = new MailMessage(fromAddress, toAddress)
                {
                    Subject = subject,
                    Body = body,
                    IsBodyHtml = true
                })
                {
                    try
                    {
                        smtp.Send(message);
                        UpdateStatus(Convert.ToInt32(dr["ID"]), Convert.ToDateTime(dr["NGAYGIO"]));
                    }
                    catch (Exception ex)
                    {

                    }

                }
            }
        }

        public static DataTable ReadThongBao()
        {
            DataSet ds = new DataSet();

            string QLUONGConnectionString = ConfigurationManager.ConnectionStrings["CBAOConnectionString"].ConnectionString;
            OleDbConnection myConnection = new OleDbConnection(QLUONGConnectionString);
            myConnection.Open();
            string queryString = "SELECT * FROM ThongBao WHERE DAGUI_MAIL = 0 AND NGAYGIO < NOW()";
            OleDbDataAdapter adapter = new OleDbDataAdapter(queryString, myConnection);
            adapter.Fill(ds);
            myConnection.Close();
            return ds.Tables[0];

        }
        public static void UpdateStatus(int ID, DateTime ngay)
        {

            string QLUONGConnectionString = ConfigurationManager.ConnectionStrings["CBAOConnectionString"].ConnectionString;
            OleDbConnection myConnection = new OleDbConnection(QLUONGConnectionString);
            string queryString = "UPDATE ThongBao SET DAGUI_MAIL = 1 WHERE ID = " + ID + " AND NGAYGIO = ?";
            OleDbCommand cmd = new OleDbCommand(queryString, myConnection);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@NGAYGIO", ngay);
            myConnection.Open();
            cmd.ExecuteNonQuery();
            myConnection.Close();
        }
    }
}
