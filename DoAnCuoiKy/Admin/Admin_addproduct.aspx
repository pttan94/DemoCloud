<%@ Page Title="Thêm sản phẩm" Language="C#" MasterPageFile="~/eWorld.Master" AutoEventWireup="true" CodeBehind="Admin_addproduct.aspx.cs" Inherits="DoAnCuoiKy.Admin.Admin_addproduct" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="space"></div>
    <asp:HyperLink runat="server" ID="back_admin" NavigateUrl="~/Admin/Admin_product.aspx">Quay về trang quản lý sản phẩm</asp:HyperLink>

    <div class="col-md-12">
        <h1>Thêm sản phẩm</h1>
        <asp:Label ID="LabelAddStatus" runat="server" Text="" Font-Size="Medium"></asp:Label>
        <div class="space"></div>
        <table>
            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server">Tên sản phẩm (*Bắt buộc):</asp:Label></td>
                <td>
                    <asp:TextBox ID="AddProductName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Text="* Product name required." ControlToValidate="AddProductName" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label2" runat="server">Mô tả:</asp:Label></td>
                <td>
                    <asp:TextBox ID="AddProductDescription" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label16" runat="server">Sản phẩm thuộc nhóm sản phẩm:</asp:Label></td>
                <td>
                    <asp:CheckBoxList ID="addProductInCategory" DataValueField="CategoryID" DataTextField="Name" runat="server" SelectMethod="GetCategories"></asp:CheckBoxList>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label3" runat="server">Cấu hình chi tiết:</asp:Label></td>
                <td>
                    <CKEditor:CKEditorControl ID="AddProductDetail" BasePath="/ckeditor/" runat="server"></CKEditor:CKEditorControl>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label4" runat="server">Giá(*Bắt buộc):</asp:Label></td>
                <td>
                    <asp:TextBox ID="AddProductPrice" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Text="* Price required." ControlToValidate="AddProductPrice" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Text="Phải nhập số" ControlToValidate="AddProductPrice" SetFocusOnError="True" Display="Dynamic" ValidationExpression="^[0-9]*(\.)?[0-9]?[0-9]?$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label6" runat="server">Đánh giá sản phẩm:</asp:Label></td>
                <td>
                    <CKEditor:CKEditorControl ID="AddProductReview" BasePath="/ckeditor/" runat="server"></CKEditor:CKEditorControl>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label7" runat="server">Tình trạng sản phẩm:</asp:Label></td>
                <td>
                    <asp:DropDownList ID="AddProductStock" runat="server" DataValueField="StockID" DataTextField="Stock" SelectMethod="GetStock"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label8" runat="server">Quà tặng:</asp:Label></td>
                <td>
                    <CKEditor:CKEditorControl ID="AddProductGift" BasePath="/ckeditor/" runat="server"></CKEditor:CKEditorControl>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label9" runat="server">Ưu đãi:</asp:Label></td>
                <td>
                    <CKEditor:CKEditorControl ID="AddProductsale" BasePath="/ckeditor/" runat="server"></CKEditor:CKEditorControl>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label10" runat="server">Hãng:</asp:Label></td>
                <td>
                    <asp:TextBox ID="AddProductVendor" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label11" runat="server">Đang giảm giá?</asp:Label></td>
                <td>
                    <asp:CheckBox ID="AddProductOnsale" runat="server"></asp:CheckBox></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label12" runat="server">Giá cũ:</asp:Label></td>
                <td>
                    <asp:TextBox ID="AddProductOldPrice" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Text="Phải nhập số" ControlToValidate="AddProductOldPrice" SetFocusOnError="True" Display="Dynamic" ValidationExpression="^[0-9]*(\.)?[0-9]?[0-9]?$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label5" runat="server">Hình ảnh 1(Hình ảnh hiển thị):</asp:Label></td>
                <td>
                    <asp:FileUpload ID="ProductImage1" runat="server" onchange="ShowImagePreview1(this);" />
                    <asp:Image ID="ImgPrv1" Height="150px" Width="240px" runat="server" /><br />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label13" runat="server">Hình ảnh 2:</asp:Label></td>
                <td>
                    <asp:FileUpload ID="ProductImage2" runat="server" onchange="ShowImagePreview2(this);"/>
                    <asp:Image ID="ImgPrv2" Height="150px" Width="240px" runat="server" /><br />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label14" runat="server">Hình ảnh 3:</asp:Label></td>
                <td>
                    <asp:FileUpload ID="ProductImage3" runat="server" onchange="ShowImagePreview3(this);"/>
                    <asp:Image ID="ImgPrv3" Height="150px" Width="240px" runat="server" /><br />
                </td>

            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label15" runat="server">Hình ảnh 4:</asp:Label></td>
                <td>
                    <asp:FileUpload ID="ProductImage4" runat="server" onchange="ShowImagePreview4(this);"/>
                    <asp:Image ID="ImgPrv4" Height="150px" Width="240px" runat="server" /><br />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label17" runat="server">Hiển thị?</asp:Label></td>
                <td>
                    <asp:CheckBox ID="Show" runat="server"></asp:CheckBox></td>
        </table>
        <asp:Button ID="AddProductButton" runat="server" Text="Thêm sản phẩm" OnClick="AddProductButton_Click" CausesValidation="true" />

    </div>
    <script>
        CKEDITOR.replace('AddProductDetail');
        CKEDITOR.replace('AddProductReview');
        CKEDITOR.replace('AddProductGift');
        CKEDITOR.replace('AddProductsale');
    </script>
    <script type="text/javascript">
        function ShowImagePreview1(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=ImgPrv1.ClientID%>').prop('src', e.target.result)
                        .width(240)
                        .height(150);
                };
                reader.readAsDataURL(input.files[0]);
                }
        }
        function ShowImagePreview2(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=ImgPrv2.ClientID%>').prop('src', e.target.result)
                        .width(240)
                        .height(150);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
        function ShowImagePreview3(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=ImgPrv3.ClientID%>').prop('src', e.target.result)
                        .width(240)
                        .height(150);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
        function ShowImagePreview4(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=ImgPrv4.ClientID%>').prop('src', e.target.result)
                        .width(240)
                        .height(150);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>

</asp:Content>
