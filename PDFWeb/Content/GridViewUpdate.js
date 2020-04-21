(function() {
    function onGridViewInit(s, e) {
        AddAdjustmentDelegate(adjustGridView);
        updateToolbarButtonsState();
    }
    function onGridViewSelectionChanged(s, e) {
        updateToolbarButtonsState();
    }
    function adjustGridView() {
        gridView.AdjustControl();
    }
    function updateToolbarButtonsState() {
        //var enabled = gridView.GetSelectedRowCount() > 0;
        //pageToolbar.GetItemByName("Delete").SetEnabled(enabled);
        //pageToolbar.GetItemByName("Export").SetEnabled(enabled);
        //pageToolbar.GetItemByName("Edit").SetEnabled(gridView.GetFocusedRowIndex() !== -1);
    }
    function onPageToolbarItemClick(s, e) {
        switch (e.item.name) {
            case "ToggleFilterPanel":
                toggleFilterPanel();
                break;
            case "New":
                ResetForm();
                popFile.Show();
                break;
            case "Export":
                gridView.ExportTo(ASPxClientGridViewExportFormat.Xlsx);
                break;
        }
    }
    function ResetForm() {
        cbbBranch.SetSelectedIndex(-1);
        cbbType.SetSelectedIndex(-1);
        txtNhom.SetText('');
        txtShortContent.SetText('');
    }

    function toggleFilterPanel() {
        filterPanel.Toggle();
    }

    function onFilterPanelExpanded(s, e) {
        adjustPageControls();
        searchButtonEdit.SetFocus();
    }
    window.onGridViewInit = onGridViewInit;
    window.onGridViewSelectionChanged = onGridViewSelectionChanged;
    window.onPageToolbarItemClick = onPageToolbarItemClick;
    window.onFilterPanelExpanded = onFilterPanelExpanded;
})();