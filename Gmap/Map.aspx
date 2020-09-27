<%@ Page Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeBehind="Map.aspx.cs" Inherits="Gmap.Map" %>

<asp:Content runat="server" ContentPlaceHolderID="Head">
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/jquery.min.js") %>'></script>
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/canvas2image.js") %>'></script>
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/html2canvas.js") %>'></script>
    <script>
        let map;
        let markers = [];
        const style = [
            {
                "featureType": "poi.business",
                "stylers": [
                    {
                        "visibility": "off"
                    }
                ]
            },
            {
                "featureType": "poi.park",
                "elementType": "labels.text",
                "stylers": [
                    {
                        "visibility": "off"
                    }
                ]
            }
        ];
        function loadMap() {
            // Create the script tag, set the appropriate attributes
            var script = document.createElement('script');
            script.src = 'https://maps.googleapis.com/maps/api/js?key=AIzaSyCnCwAjUV39EWKPHldGRpZYQom0bQMEk7c&callback=initMap';
            script.defer = true;

            // Attach your callback function to the `window` object
            window.initMap = function () {
                map = new google.maps.Map(document.getElementById('map'), {
                    zoom: 12,
                    center: { lat: 16.035407, lng: 108.222156 }
                })
                map.setOptions({ styles: style });
                AddMarker();

            };
            document.head.appendChild(script);

        };
        function attachSecretMessage(marker, secretMessage) {
            var infowindow = new google.maps.InfoWindow({
                content: secretMessage
            });
            marker.addListener('click', function () {
                infowindow.open(marker.get('map'), marker);
            });
        }


        function AddMarker() {
            var data = JSON.parse(hidPDF.Get("Data"));
            deleteMarkers();
            for (var i = 0; i < data.length; i++) {
                var marker = new google.maps.Marker({
                    position: {
                        lat: data[i].Lat,
                        lng: data[i].Lng
                    },
                    map: map,
                    animation: google.maps.Animation.DROP,
                    icon: "/Content/Icon/" + data[i].Logo
                });
                attachSecretMessage(marker, "<div style='font-weight: bold'>" + data[i].CHXD + "</div>" + "<br />" + data[i].SummaryInfo);
                markers.push(marker);
            }

        }
        function ChangeMap(s, e) {
            cpPDF.PerformCallback(s.GetValue(), AddMarker);
        }

        // Deletes all markers in the array by removing references to them.
        function deleteMarkers() {
            for (let j = 0; j < markers.length; j++) {
                markers[j].setMap(null);
            }
            markers = [];
        }

        function saveAs(uri, filename) {

            var link = document.createElement('a');

            if (typeof link.download === 'string') {

                link.href = uri;
                link.download = filename;

                //Firefox requires the link to be in the body
                document.body.appendChild(link);

                //simulate click
                link.click();

                //remove the link when done
                document.body.removeChild(link);
            } else {
                window.open(uri);
            }
        }
        function ExportImg(s, e) {
            html2canvas($("#map"), {
                useCORS: true,
                onrendered: function (canvas) {
                    saveAs(canvas.toDataURL(), 'map.png');
                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <dx:ASPxCallbackPanel ID="cpPDF" ClientInstanceName="cpPDF" runat="server" Width="200px" OnCallback="cpPDF_Callback">
        <PanelCollection>
            <dx:PanelContent runat="server">
                <dx:ASPxHiddenField ID="hidPDF" runat="server" ClientInstanceName="hidPDF">
                </dx:ASPxHiddenField>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <div>
        <table>
            <tr>
                <td style="width: 500px">
                    <dx:ASPxRadioButtonList ID="cbbTest" ItemSpacing="50px" runat="server" ValueType="System.String" SelectedIndex="0" RepeatColumns="3">
                        <Items>
                            <dx:ListEditItem Text="Hiện trạng" Value="H" />
                            <dx:ListEditItem Text="Quy hoạch" Value="Q" />
                            <dx:ListEditItem Text="Tất cả CHXD" Value="A" />
                        </Items>
                        <ClientSideEvents ValueChanged="ChangeMap" />
                        
                    </dx:ASPxRadioButtonList>
                </td>
                <td align="center">
                    <dx:ASPxButton ID="btnExport" runat="server" ClientInstanceName="btnExport" AutoPostBack="false" Text="Xuất file ảnh">
                        <ClientSideEvents Click="ExportImg" />
                    </dx:ASPxButton>
                </td>
            </tr>
        </table>


    </div>

    <div id="map" style="width: 100%; height: calc(100vh - 120px); font-weight: bold">
    </div>
</asp:Content>
