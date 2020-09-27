<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Root.master" CodeBehind="Update.aspx.cs" Inherits="Gmap.Update" Title="QUẢN LÝ NGƯỜI DÙNG" %>

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
                    <h1>HIỆU CHỈNH DỮ LIỆU</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="Thêm mới" Alignment="Right" AdaptivePriority="2">
                <Image Url="Content/Images/add.svg" />
            </dx:MenuItem>
            <dx:MenuItem Name="Export" Text="Xuất Excel" Alignment="Right" AdaptivePriority="2">
                <Image Url="Content/Images/export.svg" />
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <dx:ASPxGridView runat="server" ID="GridView" ClientInstanceName="gridView"
        KeyFieldName="ID" EnablePagingGestures="False"
        CssClass="grid-view" Width="100%" AutoGenerateColumns="False" OnInitNewRow="GridView_InitNewRow" DataSourceID="EntityDataSourceData" >
        <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" AllowEllipsisInText="true" AllowDragDrop="false" />
        <SettingsEditing Mode="PopupEditForm" EditFormColumnCount="1" />
        <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden"  ShowFilterRow="true" AutoFilterCondition="Contains" />
        <SettingsSearchPanel Visible="true" />
        <SettingsPager PageSize="10" EnableAdaptivity="true">
            <PageSizeItemSettings Visible="true"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsExport EnableClientSideExportAPI="true" />
        <SettingsText CommandEdit="Chỉnh sửa" CommandCancel="Hủy" CommandUpdate="Cập nhật" PopupEditFormCaption="Dữ liệu CHXD" />
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
            <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="0" ReadOnly="True" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CHXD" VisibleIndex="1" Caption="Tên CHXD">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn FieldName="Logo" VisibleIndex="2">
                <PropertiesComboBox ValueField="LogoID" TextField="LogoID" DataSourceID="EntityDataSourceLogo">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataMemoColumn FieldName="SummaryInfo" VisibleIndex="3" Caption="Thông tin tóm tắt" Width="200">
                <PropertiesMemoEdit Height="100"></PropertiesMemoEdit>
            </dx:GridViewDataMemoColumn>
            <dx:GridViewDataComboBoxColumn FieldName="Type" VisibleIndex="4" Caption="Nhóm">
                <PropertiesComboBox ValueType="System.String">
                    <Items>
                        <dx:ListEditItem Text="Hiện trạng" Value="H" />
                        <dx:ListEditItem Text="Quy hoạch" Value="Q" />
                    </Items>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataSpinEditColumn FieldName="Lat" VisibleIndex="5">
                <PropertiesSpinEdit MaxValue="30" NumberFormat="Custom" DisplayFormatString="N6" DisplayFormatInEditMode="true"></PropertiesSpinEdit>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn FieldName="Lng" VisibleIndex="6">
                 <PropertiesSpinEdit MaxValue="120" MinValue="100" NumberFormat="Custom" DisplayFormatString="N6" DisplayFormatInEditMode="true"></PropertiesSpinEdit>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataComboBoxColumn FieldName="Status" VisibleIndex="7" Caption="Trạng thái">
                <PropertiesComboBox ValueType="System.String">
                    <Items>
                        <dx:ListEditItem Text="Hoạt động" Value="A" />
                        <dx:ListEditItem Text="Không hoạt động" Value="I" />
                    </Items>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataDateColumn FieldName="UpdateDate" VisibleIndex="8" Caption="Người cập nhật">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="UpdateUser" VisibleIndex="9" Caption="Ngày cập nhật">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewCommandColumn ShowEditButton="true"></dx:GridViewCommandColumn>
        </Columns>
        <Styles>
            <Cell Wrap="false" />
            <PagerBottomPanel CssClass="pager" />
            <FocusedRow CssClass="focused" />
            <Header Font-Bold="true" HorizontalAlign="Center"></Header>
        </Styles>
        <ClientSideEvents Init="onGridViewInit" SelectionChanged="onGridViewSelectionChanged" />
    </dx:ASPxGridView>

    <asp:EntityDataSource OnUpdating="EntityDataSourceData_Updating" OnInserting="EntityDataSourceData_Inserting"  ID="EntityDataSourceData" runat="server" ConnectionString="name=CHXD_MapEntities" DefaultContainerName="CHXD_MapEntities" EnableDelete="False" EnableFlattening="False" EnableInsert="True" EnableUpdate="True" EntitySetName="tblDatas" EntityTypeFilter="tblData">
       
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="EntityDataSourceLogo" runat="server" ConnectionString="name=CHXD_MapEntities" DefaultContainerName="CHXD_MapEntities" EnableFlattening="False" EntitySetName="tblLogoes">
    </asp:EntityDataSource>
</asp:Content>

<%--<asp:Content runat="server" ContentPlaceHolderID="RightPanelContent">
    <div class="settings-content">
        <h2>Settings</h2>
        <p>Place your content here</p>
    </div>
</asp:Content>--%>