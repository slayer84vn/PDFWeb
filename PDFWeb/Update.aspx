<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Root.master" CodeBehind="Update.aspx.cs" Inherits="PDFWeb.Update" Title="CẬP NHẬT" %>

<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.10.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data.Linq" TagPrefix="dx" %>


<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridViewUpdate_1.js") %>'></script>
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
                    <h1>CẬP NHẬT DỮ LIỆU</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="Thêm mới" Alignment="Right" AdaptivePriority="2">
                <Image Url="Content/Images/add.svg" />
            </dx:MenuItem>
            <dx:MenuItem Name="Export" Text="Xuất Excel" Alignment="Right" AdaptivePriority="2">
                <Image Url="Content/Images/export.svg" />
            </dx:MenuItem>
            <dx:MenuItem Name="ToggleFilterPanel" Text="" GroupName="Filter" Alignment="Right" AdaptivePriority="1">
                <Image Url="Content/Images/search.svg" UrlChecked="Content/Images/search-selected.svg" />
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>
        <dx:ASPxPanel runat="server" ID="FilterPanel" ClientInstanceName="filterPanel"
        Collapsible="true" CssClass="filter-panel">
        <SettingsCollapsing ExpandEffect="Slide" AnimationType="Slide" ExpandButton-Visible="false" />
        <PanelCollection>
            <dx:PanelContent>
                <dx:ASPxButtonEdit runat="server" ID="SearchButtonEdit" ClientInstanceName="searchButtonEdit" ClearButton-DisplayMode="Always" Caption="Search" Width="100%" />
            </dx:PanelContent>
        </PanelCollection>
        <ClientSideEvents Expanded="onFilterPanelExpanded" Collapsed="adjustPageControls" />
    </dx:ASPxPanel>

</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <dx:ASPxGridView runat="server" ID="GridView" ClientInstanceName="gridView" EnableCallBacks="false"
        KeyFieldName="ID" EnablePagingGestures="False"
        CssClass="grid-view" Width="100%" AutoGenerateColumns="False" DataSourceID="EntityDataSourceFile" OnStartRowEditing="GridView_StartRowEditing" OnRowDeleting="GridView_RowDeleting">
        <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" AllowEllipsisInText="true" AllowDragDrop="false" ConfirmDelete="true" />
        <SettingsEditing Mode="PopupEditForm" EditFormColumnCount="1" />
        <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Auto"  />
        <SettingsSearchPanel CustomEditorID="SearchButtonEdit" />
        <SettingsPager PageSize="10" EnableAdaptivity="true">
            <PageSizeItemSettings Visible="true"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsExport EnableClientSideExportAPI="true" />
        <SettingsText CommandEdit="Chỉnh sửa" ConfirmDelete="Bạn có muốn xóa file này không?" CommandDelete="Xóa" CommandCancel="Hủy" CommandUpdate="Cập nhật" PopupEditFormCaption="Nhóm người dùng" />
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
            <dx:GridViewCommandColumn Caption="#" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="0" Width="150"></dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="FileName" VisibleIndex="1" Caption="File dữ liệu" Width="200">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn FieldName="BranchID" VisibleIndex="2" Caption="Đơn vị" Width="190" Settings-AllowFilterBySearchPanel="False">
                <PropertiesComboBox ValueField="BranchID" TextField="BranchName" DataSourceID="EntityDataSourceBranch">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="TypeID" VisibleIndex="3" Caption="Loại dữ liệu" Width="150" Settings-AllowFilterBySearchPanel="False">
                <PropertiesComboBox ValueField="TypeID" TextField="TypeName" DataSourceID="EntityDataSourceType">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataMemoColumn FieldName="ShortContent" VisibleIndex="4" Caption="Nội dung tóm lược" Width="300" AllowTextTruncationInAdaptiveMode="true">
            </dx:GridViewDataMemoColumn>
            <dx:GridViewDataTokenBoxColumn FieldName="GroupAccess" VisibleIndex="5" Caption="Nhóm truy cập" Width="150" Settings-AllowFilterBySearchPanel="False">
                <PropertiesTokenBox AllowCustomTokens="false" ValueField="GroupID" TextField="GroupName" DataSourceID="EntityDataSourceGroup">
                </PropertiesTokenBox>
            </dx:GridViewDataTokenBoxColumn>
            <dx:GridViewDataTextColumn FieldName="UpdatedUser" VisibleIndex="6" Caption="Người cập nhật" Width="130" Settings-AllowFilterBySearchPanel="False">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="UpdatedDate" VisibleIndex="7" Caption="Ngày cập nhật" Width="130" Settings-AllowFilterBySearchPanel="False">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataCheckColumn FieldName="IsLock" VisibleIndex="8" Caption="Trạng thái Lock" Width="130" Settings-AllowFilterBySearchPanel="False">
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

    <asp:EntityDataSource ID="EntityDataSourceFile" runat="server" ConnectionString="name=PDFEntities" DefaultContainerName="PDFEntities" EnableFlattening="False" EnableInsert="True" EnableDelete="True" EnableUpdate="True" EntitySetName="tblPDF_FileData" 
        Where="@GroupID = 'QL' OR it.BranchID = @BranchID" OrderBy="it.UpdatedDate DESC">
        <WhereParameters>
            <asp:SessionParameter Name="GroupID" SessionField="GroupID"  DbType="String"/>
            <asp:SessionParameter Name="BranchID" SessionField="BranchID" DbType="String"/>
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="EntityDataSourceGroup" Where="it.IsEnable = true" runat="server" ConnectionString="name=PDFEntities" DefaultContainerName="PDFEntities" EnableFlattening="False" EntitySetName="tblDM_Group">
    </asp:EntityDataSource>
   <asp:EntityDataSource ID="EntityDataSourceType" Where="it.IsEnable = true" runat="server" ConnectionString="name=PDFEntities" DefaultContainerName="PDFEntities" EnableFlattening="False" EntitySetName="tblDM_Type">
    </asp:EntityDataSource>
   <asp:EntityDataSource ID="EntityDataSourceBranch" Where="it.IsEnable = true" runat="server" ConnectionString="name=PDFEntities" DefaultContainerName="PDFEntities" EnableFlattening="False" EntitySetName="tblDM_Branch">
    </asp:EntityDataSource>

    <dx:ASPxPopupControl ID="popFile" runat="server" ClientInstanceName="popFile"
        HeaderText="CẬP NHẬT FILE DỮ LIỆU" Width="400px" Height="330px" Modal="True" PopupHorizontalAlign="WindowCenter"
        PopupVerticalAlign="WindowCenter">
        <HeaderStyle Font-Bold="True" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <table style="width:100%;">
                    <tr style="height:35px">
                        <td align="right">
                            <dx:ASPxUploadControl ID="txtFile"  runat="server"  Width="100%" UploadMode="Standard" AdvancedModeSettings-EnableMultiSelect="false">
                                <BrowseButton Text="Chọn file PDF để Upload" >
                                    <Image IconID="pdfviewer_documentpdf_svg_16x16">
                                    </Image>
                                </BrowseButton>
                                <ValidationSettings AllowedFileExtensions=".pdf">
                                </ValidationSettings>
                            </dx:ASPxUploadControl>
                        </td>
                    </tr>
                    <tr style="height:35px">
                        <td align="right">
                            <dx:ASPxComboBox ID="cbbBranch" runat="server" Caption="Đơn vị" ClientInstanceName="cbbBranch"
                                Width="300px" DataSourceID="EntityDataSourceBranch" ValueField="BranchID" TextField="BranchName">
                                <CaptionSettings ShowColon="False" />
                                <ValidationSettings Display="Dynamic"> 
                                    <RequiredField IsRequired="True"/>
                                </ValidationSettings>
                                <CaptionStyle Font-Bold="True">
                                </CaptionStyle>
                            </dx:ASPxComboBox>
                        </td>
                    </tr>

                    <tr style="height:35px">
                        <td align="right">
                            <dx:ASPxComboBox ID="cbbType" runat="server" Caption="Loại dữ liệu" ClientInstanceName="cbbType"
                                Width="300px" DataSourceID="EntityDataSourceType" ValueField="TypeID" TextField="TypeName">
                                <CaptionSettings ShowColon="False" />
                                <ValidationSettings Display="Dynamic"> 
                                    <RequiredField IsRequired="True"/>
                                </ValidationSettings>
                                <CaptionStyle Font-Bold="True">
                                </CaptionStyle>
                            </dx:ASPxComboBox>
                        </td>
                    </tr>
                    <tr style="height:90px">
                        <td align="right">
                            <dx:ASPxMemo ID="txtShortContent" runat="server" Caption="Nội dung tóm tắt" Rows="4" Width="300px" ClientInstanceName="txtShortContent" >
                                <CaptionSettings ShowColon="False" />
                                <ValidationSettings Display="Dynamic">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                                <CaptionStyle Font-Bold="True">
                                </CaptionStyle>
                            </dx:ASPxMemo>
                        </td>
                    </tr>
                   <tr style="height:35px">
                        <td align="right">
                            <dx:ASPxTokenBox ID="txtNhom" runat="server" ClientInstanceName="txtNhom" Caption="Các nhóm truy cập"  Width="300px" AllowCustomTokens="false" DataSourceID="EntityDataSourceGroup" ValueField="GroupID" TextField="GroupName" CaseSensitiveTokens="False"  IncrementalFilteringMode="None">
                                <CaptionSettings ShowColon="False" />
                                <ValidationSettings Display="Dynamic">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                                <CaptionStyle Font-Bold="True">
                                </CaptionStyle>
                            </dx:ASPxTokenBox>
                        </td>
                    </tr>
                    <tr style="height:35px">
                        <td align="center" >
                            <dx:ASPxButton ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Thực hiện">
                                <Image IconID="actions_apply_16x16">
                                </Image>
                            </dx:ASPxButton>
                        </td>
                    </tr>
                </table>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

</asp:Content>

<%--<asp:Content runat="server" ContentPlaceHolderID="RightPanelContent">
    <div class="settings-content">
        <h2>Settings</h2>
        <p>Place your content here</p>
    </div>
</asp:Content>--%>