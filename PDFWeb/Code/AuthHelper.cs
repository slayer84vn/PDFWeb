using PDFWeb.Code;
using System.Web;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System;

namespace PDFWeb.Model {

    public static class AuthHelper {
        public static tblDM_User SignIn(string userName, string password) {
            using (PDFEntities entities = new PDFEntities())
            {
                string passMd5 = GetMD5(password);
                tblDM_User user = entities.tblDM_User.FirstOrDefault(z => z.UserName == userName && z.Pass == passMd5 && z.IsLock == false);
                HttpContext.Current.Session["User"] = user;
                if (user != null)
                {
                    HttpContext.Current.Session["UserName"] = user.UserName;
                    HttpContext.Current.Session["GroupID"] = user.GroupID;
                    HttpContext.Current.Session["BranchID"] = user.BranchID;
                }
                return user;
            }
            
        }
        public static void SignOut() {
            HttpContext.Current.Session["User"] = null;
        }
        public static bool IsAuthenticated() {
            return GetLoggedInUserInfo() != null;
        }

        public static tblDM_User GetLoggedInUserInfo() {
            return HttpContext.Current.Session["User"] as tblDM_User;
        }

        public static string GetMD5(string str)
        {
            MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
            byte[] bHash = md5.ComputeHash(Encoding.UTF8.GetBytes(str));
            StringBuilder sbHash = new StringBuilder();
            foreach (byte b in bHash)
            {
                sbHash.Append(String.Format("{0:x2}", b));
            }
            return sbHash.ToString();
        }
    }
}