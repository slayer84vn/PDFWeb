<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Root.master" CodeBehind="DeniedPage.aspx.cs" Inherits="PDFWeb.DeniedPage" Title="ACCESS DENIED" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageContent" runat="server">
    <div runat="server" id="divError" visible = "true"  style="color:red">
        <h1>
            Bạn không có quyền truy cập chức năng này</h1>
    </div>
</asp:Content>
