<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Root.master" CodeBehind="User.aspx.cs" Inherits="PDFWeb.User" Title="QUẢN LÝ NGƯỜI DÙNG" %>

<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.10.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data.Linq" TagPrefix="dx" %>


<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridViewSimple.js") %>'></script>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="PageToolbar">
    <dx:ASPxMenu runat="server" ID="PageToolbar" ClientInstanceName="pageToolbar"
        ItemAutoWidth="false" ApplyItemStyleToTemplates="true" ItemWrap="false"
        AllowSelectItem="false" SeparatorWidth="0"
        Width="100%" CssClass="page-toolbar">
        <ClientSideEvents ItemClick="onPageToolbarItemClick" />
        <SettingsAdaptivity Enabled="true" EnableAutoHideRootItems="true"
            EnableCollapseRootItemsToIcons="true" CollapseRootItemsToIconsAtWindowInnerWidth="600" />
        <ItemStyle CssClass="item" VerticalAlign="Middle" />
        <ItemImage Width="16px" Height="16px" />
        <Items>
            <dx:MenuItem Enabled="false">
                <Template>
                    <h1>QUẢN LÝ NGƯỜI DÙNG</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="Thêm mới" Alignment="Right" AdaptivePriority="2">
                <Image Url="Content/Images/add.svg" />
            </dx:MenuItem>
            <dx:MenuItem Name="ResetPass" Text="Reset Pass" Alignment="Right" AdaptivePriority="2">
                <Image Url="Content/Images/edit.svg" />
            </dx:MenuItem>
            <%--            <dx:MenuItem Name="Delete" Text="Delete" Alignment="Right" AdaptivePriority="2">
                <Image Url="Content/Images/delete.svg" />
            </dx:MenuItem>--%>
            <dx:MenuItem Name="Export" Text="Xuất Excel" Alignment="Right" AdaptivePriority="2">
                <Image Url="Content/Images/export.svg" />
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <dx:ASPxGridView runat="server" ID="GridView" ClientInstanceName="gridView"
        KeyFieldName="UserName" EnablePagingGestures="False"
        CssClass="grid-view" Width="100%" AutoGenerateColumns="False" DataSourceID="EntityDataSourceUser" OnRowInserting="GridView_RowInserting" OnInitNewRow="GridView_InitNewRow" OnCustomCallback="GridView_CustomCallback">
        <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" AllowEllipsisInText="true" AllowDragDrop="false" />
        <SettingsEditing Mode="PopupEditForm" EditFormColumnCount="1" />
        <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />
        <SettingsSearchPanel Visible ="true" />
        <SettingsPager PageSize="10" EnableAdaptivity="true">
            <PageSizeItemSettings Visible="true"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsExport EnableClientSideExportAPI="true" />
        <SettingsText CommandEdit="Chỉnh sửa" CommandCancel="Hủy" CommandUpdate="Cập nhật" PopupEditFormCaption="Nhóm người dùng" />
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
            <dx:GridViewCommandColumn Caption="#" ShowEditButton="true" VisibleIndex="0" Width="100"></dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="UserName" VisibleIndex="1" Caption="UserName">
                <PropertiesTextEdit>
                    <ValidationSettings RequiredField-IsRequired="true"></ValidationSettings>
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn FieldName="BranchID" VisibleIndex="2" Caption="Đơn vị" Width="150" Settings-AllowFilterBySearchPanel="False">
                <PropertiesComboBox ValueField="BranchID" TextField="BranchName" DataSourceID="EntityDataSourceBranch">
                    <ValidationSettings RequiredField-IsRequired="true"></ValidationSettings>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn FieldName="GroupID" VisibleIndex="2" Caption="Nhóm người dùng">
                <PropertiesComboBox ValueField="GroupID" TextField="GroupName" DataSourceID="EntityDataSourceGroup">
                    <ValidationSettings RequiredField-IsRequired="true"></ValidationSettings>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataCheckColumn FieldName="IsLock" VisibleIndex="3" Caption="Trạng thái Lock">
                <PropertiesCheckEdit>
                    <ValidationSettings RequiredField-IsRequired="true"></ValidationSettings>
                </PropertiesCheckEdit>
            </dx:GridViewDataCheckColumn>
        </Columns>
        <Styles>
            <Cell Wrap="false" />
            <PagerBottomPanel CssClass="pager" />
            <FocusedRow CssClass="focused" />
            <Header Font-Bold="true" HorizontalAlign="Center"></Header>
        </Styles>
        <ClientSideEvents Init="onGridViewInit" SelectionChanged="onGridViewSelectionChanged" />
    </dx:ASPxGridView>

    <asp:EntityDataSource ID="EntityDataSourceUser" runat="server" ConnectionString="name=PDFEntities" DefaultContainerName="PDFEntities" EnableFlattening="False" EnableInsert="True" EnableUpdate="True" EntitySetName="tblDM_User">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="EntityDataSourceGroup" runat="server" ConnectionString="name=PDFEntities" DefaultContainerName="PDFEntities" EnableFlattening="False" EntitySetName="tblDM_Group">
    </asp:EntityDataSource>
       <asp:EntityDataSource ID="EntityDataSourceBranch" runat="server" ConnectionString="name=PDFEntities" DefaultContainerName="PDFEntities" EnableFlattening="False" EntitySetName="tblDM_Branch">
    </asp:EntityDataSource>
</asp:Content>

<%--<asp:Content runat="server" ContentPlaceHolderID="RightPanelContent">
    <div class="settings-content">
        <h2>Settings</h2>
        <p>Place your content here</p>
    </div>
</asp:Content>--%>