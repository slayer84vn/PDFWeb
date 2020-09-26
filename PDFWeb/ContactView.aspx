<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Root.master" CodeBehind="ContactView.aspx.cs" Inherits="PDFWeb.ContactView" Title="DANH BẠ ĐƠN VỊ" %>

<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.10.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data.Linq" TagPrefix="dx" %>


<asp:Content runat="server" ContentPlaceHolderID="Head">
    <LINK REL="SHORTCUT ICON"  HREF="danhba.ico"/>
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridViewSimple.js") %>'></script>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <dx:ASPxGridView runat="server" ID="GridView" ClientInstanceName="gridView"
        KeyFieldName="ID" EnablePagingGestures="False"
        CssClass="grid-view" Width="100%" AutoGenerateColumns="False" DataSourceID="EntityDataSourceContact">
        <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" AllowEllipsisInText="true" AllowDragDrop="false" ConfirmDelete="true" AllowAutoFilter="true" FilterRowMode="Auto"  />
        <SettingsEditing Mode="PopupEditForm" EditFormColumnCount="1" />
        <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" ShowFilterRow="true"  AutoFilterCondition="Contains"/>
        <SettingsPager PageSize="15" EnableAdaptivity="true">
            <PageSizeItemSettings Visible="true"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsSearchPanel  Visible="true"/>
        <SettingsExport EnableClientSideExportAPI="true" />
        <SettingsText CommandEdit="Chỉnh sửa" CommandCancel="Hủy" CommandUpdate="Cập nhật" ConfirmDelete="Bạn có muốn xoá không" CommandDelete="Xoá" PopupEditFormCaption="Đơn vị" />
        <SettingsPopup>
            <EditForm>
                <SettingsAdaptivity MaxWidth="400" Mode="Always" VerticalAlign="WindowCenter" />
            </EditForm>
            <HeaderFilter MinHeight="140px"></HeaderFilter>
        </SettingsPopup>
        <EditFormLayoutProperties UseDefaultPaddings="false">
            <Styles LayoutItem-Paddings-PaddingBottom="8">
                <LayoutItem>
                    <Paddings PaddingBottom="8px"></Paddings>
                </LayoutItem>
            </Styles>
            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="600">
            </SettingsAdaptivity>
        </EditFormLayoutProperties>
        <Columns>
<%--            <dx:GridViewCommandColumn Caption="#" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="0" Width="130"></dx:GridViewCommandColumn>--%>
            <dx:GridViewDataComboBoxColumn FieldName="DonVi" VisibleIndex="1" Caption="Đơn vị">
                <PropertiesComboBox DataSourceID="EntityDataSourceDonVi" ValueField="DonVi" TextField="DonVi">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic"></ValidationSettings>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="PhongBan" VisibleIndex="2" Caption="Phòng ban">
                <PropertiesComboBox DataSourceID="EntityDataSourcePhongBan" ValueField="PhongBan" TextField="PhongBan">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic"></ValidationSettings>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn FieldName="ChucDanh" VisibleIndex="3" Caption="Chức danh">
                <PropertiesTextEdit>
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic"></ValidationSettings>
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="HoTen" VisibleIndex="4" Caption="Họ tên">
                <PropertiesTextEdit>
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic"></ValidationSettings>
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CoQuan" VisibleIndex="5" Caption="Cơ quan" Width="100">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NoiBo" VisibleIndex="6" Caption="Nội bộ" Width="80">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DiDong" VisibleIndex="7" Caption="Di động" Width="120">
            </dx:GridViewDataTextColumn>
        </Columns>
        <Styles>
            <Cell Wrap="false" />
            <PagerBottomPanel CssClass="pager" />
            <FocusedRow CssClass="focused" />
            <Header Font-Bold="true" HorizontalAlign="Center"></Header>
        </Styles>
    </dx:ASPxGridView>

    <asp:EntityDataSource ID="EntityDataSourceContact" runat="server" ConnectionString="name=PDFEntities" DefaultContainerName="PDFEntities" EnableFlattening="False"  EntitySetName="tblDM_DanhBa">
    </asp:EntityDataSource>
        <asp:EntityDataSource ID="EntityDataSourceDonVi" runat="server" ConnectionString="name=PDFEntities" DefaultContainerName="PDFEntities" EnableFlattening="False"  EntitySetName="tblDM_DonVi">
    </asp:EntityDataSource>
        <asp:EntityDataSource ID="EntityDataSourcePhongBan" runat="server" ConnectionString="name=PDFEntities" DefaultContainerName="PDFEntities" EnableFlattening="False"  EntitySetName="tblDM_PhongBan">
    </asp:EntityDataSource>
</asp:Content>

<%--<asp:Content runat="server" ContentPlaceHolderID="RightPanelContent">
    <div class="settings-content">
        <h2>Settings</h2>
        <p>Place your content here</p>
    </div>
</asp:Content>--%>