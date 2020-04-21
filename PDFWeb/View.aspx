<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Root.master" CodeBehind="View.aspx.cs" Inherits="PDFWeb.View" Title="VIEW FILE PDF" %>

<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
<%--    <script type="text/javascript" src='<%# ResolveUrl("~/Content/View.js") %>'></script>--%>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="PageToolbar">
    <dx:ASPxMenu runat="server" ID="PageToolbar" ClientInstanceName="pageToolbar"
        ItemAutoWidth="false" ApplyItemStyleToTemplates="true" ItemWrap="false"
        AllowSelectItem="false" SeparatorWidth="0"
        Width="100%" CssClass="page-toolbar">
<%--        <ClientSideEvents ItemClick="onPageToolbarItemClick" />--%>
        <SettingsAdaptivity Enabled="true" EnableAutoHideRootItems="true"
            EnableCollapseRootItemsToIcons="true" CollapseRootItemsToIconsAtWindowInnerWidth="600" />
        <ItemStyle CssClass="item" VerticalAlign="Middle" />
        <ItemImage Width="16px" Height="16px" />
        <Items>
            <dx:MenuItem Enabled="false">
                <Template>
                    <h1>VIEW FILE PDF</h1>
                </Template>
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">

     <asp:Literal ID="ltEmbed" runat="server" />
      <div id="divContent" runat="server" style="width:100%" visible="false">
          <table style="width:100%;border-collapse: separate; border-spacing: 4px">
              <tr>
                  <td style="width:100px">Các ý kiến</td>
                   <td colspan="2">
                       <dx:ASPxMemo ID="txtIdeas" runat="server" Width="100%" Height="71px" ReadOnly="True"></dx:ASPxMemo>
                   </td>
              </tr>
              <tr>
                  <td style="width:100px">Ý kiến</td>
                  <td>
                      <dx:ASPxMemo ID="txtIdea" runat="server" Width="100%" Rows="1" Height="30px">
                          <ValidationSettings ValidationGroup="123" Display="Dynamic">
                              <RequiredField IsRequired="True" />
                          </ValidationSettings>
                      </dx:ASPxMemo>
                  </td>
                  <td style="width:100px">
                      <dx:ASPxButton ID="btnSave" runat="server" Text="Lưu" OnClick="btnSave_Click" ValidationGroup="123"  Width="110px">
                          <Image IconID="save_save_svg_white_16x16">
                          </Image>
                      </dx:ASPxButton>
                  </td>
              </tr>
              <tr>
                  <td style="width:100px">Địa chỉ mail</td>
                  <td>
                      <dx:ASPxTokenBox ID="txtMailAddress" runat="server" Width="100%" AllowCustomTokens="false"  DataSourceID="EntityDataSourceMail" ValueField="Email" TextField="Email" TextSeparator=";" DataSecurityMode="Strict" IncrementalFilteringMode="None">
                          <ValidationSettings ValidationGroup="4" Display="Dynamic">
                              <RequiredField IsRequired="True" />
                          </ValidationSettings>
                      </dx:ASPxTokenBox>
                         <asp:EntityDataSource ID="EntityDataSourceMail" Where="it.IsEnable = true" runat="server" ConnectionString="name=PDFEntities" DefaultContainerName="PDFEntities" EnableFlattening="False" EntitySetName="tblDM_Mail">
                        </asp:EntityDataSource>
                  </td>
                  <td style="width:100px">
                      <dx:ASPxButton ID="btnSendMail" runat="server" Text="Gửi mail" OnClick="btnSendMail_Click" ValidationGroup="4" Width="110px">
                          <Image IconID="businessobjects_bo_resume_svg_white_16x16">
                          </Image>
                      </dx:ASPxButton>
                  </td>
              </tr>
              <tr>
                  <td colspan="3">
                       <dx:ASPxButton ID="btnPrintAll" runat="server" Text="In PDF cùng ý kiến" OnClick="btnPrintAll_Click" >
                          <Image IconID="dashboards_print_svg_white_16x16">
                          </Image>
                      </dx:ASPxButton>
                       <dx:ASPxButton ID="btnPrintIdea" runat="server" Text="In ý kiến" OnClick="btnPrintIdea_Click" >
                          <Image IconID="print_printdialog_svg_white_16x16">
                          </Image>
                      </dx:ASPxButton>
                      <dx:ASPxButton ID="btnLock" runat="server" Text="Khóa dữ liệu" OnClick="btnLock_Click">
                          <Image IconID="outlookinspired_private_svg_white_16x16">
                          </Image>
                      </dx:ASPxButton>
                      <dx:ASPxButton ID="btnClose" runat="server" Text="Đóng dữ liệu" OnClick="btnClose_Click">
                          <ClientSideEvents Click="function(s, e) {
	                            e.processOnServer=confirm('Bạn có muốn đóng dữ liệu này không?');
                            }" />
                          <Image IconID="richedit_clearheaderandfooter_svg_white_16x16">
                          </Image>
                      </dx:ASPxButton>
                  </td>
              </tr>
          </table>
      </div>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="LeftPanelContent">
    <h3 class="leftpanel-section section-caption">DANH SÁCH FILE</h3>
   <dx:ASPxTreeView ID="treeView" runat="server" EnableCallBacks="true" OnVirtualModeCreateChildren="treeView_VirtualModeCreateChildren" OnNodeClick="treeView_NodeClick">
        <Images NodeImage-Width="16px">
        </Images>
        <Styles NodeImage-Paddings-PaddingTop="2px">
        </Styles>
    </dx:ASPxTreeView>
</asp:Content>

