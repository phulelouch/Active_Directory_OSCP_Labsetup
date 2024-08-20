<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Text" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        string authHeader = Request.Headers["Authorization"];
        if (string.IsNullOrEmpty(authHeader) || !AuthenticateUser(authHeader))
        {
            Response.StatusCode = 401; // Unauthorized
            Response.AddHeader("WWW-Authenticate", "Basic realm=\"Secure Area\"");
            Response.End();
            return;
        }

        if (IsPostBack)
        {
            if (Request.Files.Count > 0)
            {
                HttpPostedFile file = Request.Files[0];
                if (file != null && file.ContentLength > 0)
                {
                    string fname = Path.GetFileName(file.FileName);
                    string savePath = Server.MapPath(fname); // Saving file in the same directory as the ASPX file
                    file.SaveAs(savePath);
                    lblMessage.Text = "File uploaded successfully!";
                }
            }
        }
    }

    private bool AuthenticateUser(string authHeader)
    {
        string encodedUsernamePassword = authHeader.Substring("Basic ".Length).Trim();
        Encoding encoding = Encoding.GetEncoding("iso-8859-1");
        string usernamePassword = encoding.GetString(Convert.FromBase64String(encodedUsernamePassword));

        int separatorIndex = usernamePassword.IndexOf(':');
        string username = usernamePassword.Substring(0, separatorIndex);
        string password = usernamePassword.Substring(separatorIndex + 1);

        // Replace "EVANGELINA" with your actual username and password.
        return username == "EVANGELINA" && password == "EVANGELINA";
    }
</script>

<!DOCTYPE html>
<html>
<head>
    <title>Secure File Upload</title>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <input type="file" id="fileUpload" runat="server" />
        <input type="submit" value="Upload" runat="server" />
        <br />
        <asp:Label id="lblMessage" runat="server" />
    </form>
</body>
</html>
