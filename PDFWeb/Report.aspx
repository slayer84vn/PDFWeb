<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Root.master" CodeBehind="Report.aspx.cs" Inherits="PDFWeb.Report" Title="THỐNG KÊ" %>

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
        <SettingsAdaptivity Enabled="true" EnableAutoHideRootItems="true"
            EnableCollapseRootItemsToIcons="true" CollapseRootItemsToIconsAtWindowInnerWidth="600" />
        <ItemStyle CssClass="item" VerticalAlign="Middle" />
        <ItemImage Width="16px" Height="16px" />
        <Items>
            <dx:MenuItem Enabled="false">
                <Template>
                    <h1>THỐNG KÊ DỮ LIỆU</h1>
                </Template>
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <div style="width:100%">
        <table style="width:100%; border-collapse: separate; border-spacing: 4px">
            <tr>
                <td style="width:100px"></td>
                <td style="width:330px">
                    <dx:ASPxDateEdit ID="dtpFromDate" Caption="Từ ngày" runat="server" CaptionSettings-ShowColon="false" Width="200px">
                        <CaptionStyle Font-Bold="true"></CaptionStyle>
                        <CaptionCellStyle Width="100"></CaptionCellStyle>
                    </dx:ASPxDateEdit>
                </td>
                <td style="width:330px">
                    <dx:ASPxDateEdit ID="dtpToDate" Caption="Đến ngày" runat="server" CaptionSettings-ShowColon="false" Width="200px">
                        <CaptionStyle Font-Bold="true"></CaptionStyle>
                        <CaptionCellStyle Width="100"></CaptionCellStyle>
                    </dx:ASPxDateEdit>
                </td>
                <td></td>
            </tr>
               <tr>
                <td style="width:100px"></td>
                <td>
                     <dx:ASPxComboBox ID="cbbBranch" runat="server" Caption="Đơn vị" DropDownStyle="DropDownList"
                        Width="200px" DataSourceID="EntityDataSourceBranch" IncrementalFilteringMode="None" ValueField="BranchID" TextField="BranchName">
                         <ClearButton DisplayMode="Always">
                         </ClearButton>
                        <CaptionSettings ShowColon="False" />
                        <CaptionStyle Font-Bold="True">
                        </CaptionStyle>
                         <CaptionCellStyle Width="100"></CaptionCellStyle>
                    </dx:ASPxComboBox>
                </td>
                <td>
                    <dx:ASPxComboBox ID="cbbType" runat="server" Caption="Loại dữ liệu" DropDownStyle="DropDownList"
                        Width="200px" DataSourceID="EntityDataSourceType" IncrementalFilteringMode="None" ValueField="TypeID" TextField="TypeName">
                        <ClearButton DisplayMode="Always">
                        </ClearButton>
                        <CaptionSettings ShowColon="False" />
                        <CaptionStyle Font-Bold="True">
                        </CaptionStyle>
                        <CaptionCellStyle Width="100"></CaptionCellStyle>
                    </dx:ASPxComboBox>
                </td>
                <td align="left">
                    <dx:ASPxButton ID="btnView" runat="server" Text="Xem dữ liệu">
                        <Image IconID="find_find_svg_white_16x16" Width="130px">
                        </Image>
                    </dx:ASPxButton>
                    &nbsp;
                    <dx:ASPxButton ID="btnExport" runat="server" Text="Xuất Excel" Width="130px" OnClick="btnExport_Click">
                        <Image IconID="dashboards_print_svg_white_16x16">
                        </Image>
                    </dx:ASPxButton>
                </td>
            </tr>
        </table>
    </div>
    <dx:ASPxGridView runat="server" ID="GridView" ClientInstanceName="gridView" EnableCallBacks="false"
        KeyFieldName="ID" EnablePagingGestures="False"
        CssClass="grid-view" Width="100%" AutoGenerateColumns="False" DataSourceID="EntityDataSourceFile">
        <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" AllowEllipsisInText="true" AllowDragDrop="false" ConfirmDelete="true" />
        <SettingsEditing Mode="PopupEditForm" EditFormColumnCount="1" />
        <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden"  />
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
            <dx:GridViewDataMemoColumn FieldName="Idea" VisibleIndex="8" Caption="Các ý kiến" Width="230" Settings-AllowFilterBySearchPanel="False">
            <Settings AllowEllipsisInText="False" />
                <CellStyle Wrap="True"></CellStyle>
            </dx:GridViewDataMemoColumn>
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
        Where="(@BranchID IS NULL OR it.BranchID = @BranchID) AND (it.UpdatedDate BETWEEN @FromDate AND @ToDate) AND (@TypeID IS NULL OR it.TypeID = @TypeID)" 
        OrderBy="it.UpdatedDate DESC">
        <WhereParameters>
            <asp:ControlParameter Name="FromDate" ControlID="dtpFromDate" DbType="Date"/>
            <asp:ControlParameter Name="ToDate" ControlID="dtpToDate" DbType="Date"/>
            <asp:ControlParameter Name="BranchID" ControlID="cbbBranch" DbType="String"/>
            <asp:ControlParameter Name="TypeID" ControlID="cbbType" DbType="String"/>
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="EntityDataSourceGroup" runat="server" ConnectionString="name=PDFEntities" DefaultContainerName="PDFEntities" EnableFlattening="False" EntitySetName="tblDM_Group">
    </asp:EntityDataSource>
   <asp:EntityDataSource ID="EntityDataSourceType" runat="server" ConnectionString="name=PDFEntities" DefaultContainerName="PDFEntities" EnableFlattening="False" EntitySetName="tblDM_Type">
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