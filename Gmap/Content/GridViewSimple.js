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
        switch(e.item.name) {
            case "New":
                gridView.AddNewRow();
                break;
            case "Edit":
                gridView.StartEditRow(gridView.GetFocusedRowIndex());
                break;
            case "Delete":
                deleteSelectedRecords();
                break;
            case "ResetPass":
                if (confirm('Bạn có muốn Reset Pass không?')) {
                    gridView.PerformCallback('ResetPass');
                };
                break;
            case "Export":
                gridView.ExportTo(ASPxClientGridViewExportFormat.Xlsx);
                break;
            case "ExportPDF":
                gridView.ExportTo(ASPxClientGridViewExportFormat.Pdf);
                break;
        }
    }
    function deleteSelectedRecords() {
        if(confirm('Confirm Delete?')) {
            gridView.PerformCallback('delete');
        }
    }
    window.onGridViewInit = onGridViewInit;
    window.onGridViewSelectionChanged = onGridViewSelectionChanged;
    window.onPageToolbarItemClick = onPageToolbarItemClick;
})();