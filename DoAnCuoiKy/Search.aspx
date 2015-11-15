<%@ Page Title="Tìm kiếm" Language="C#" MasterPageFile="~/eWorld.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="DoAnCuoiKy.Search" %>

<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div id="Content">
        <div class="Content pdr col-md-12">
            <div class="Content col-md-10 clearfix">
                <div class="breadcrumb">
                    <a href="/Default.aspx">Trang chủ</a> &gt;
                    <asp:HyperLink ID="Link_cate" runat="server" href="~Search.aspx">Tìm kiếm</asp:HyperLink>
                </div>
                <asp:Label runat="server" ID="title_search"></asp:Label>
                <div id="search_product" class="clearfix">
                    <div class="search_product">Tìm kiếm sản phẩm theo: </div>
                    <div class="search_product">
                        <span>Mức giá</span>
                        <asp:DropDownList ID="search_price" runat="server" AutoPostBack="true" OnSelectedIndexChanged="PriceSearch_SelectedIndexChanged">
                            <asp:ListItem Value="0">--Tất cả--</asp:ListItem>
                            <asp:ListItem Value="2000000">Trên 2 triệu</asp:ListItem>
                            <asp:ListItem Value="4000000">Trên 4 triệu</asp:ListItem>
                            <asp:ListItem Value="6000000">Trên 6 triệu</asp:ListItem>
                            <asp:ListItem Value="8000000">Trên 8 triệu</asp:ListItem>
                            <asp:ListItem Value="10000000">Trên 10 triệu</asp:ListItem>
                        </asp:DropDownList>

                    </div>
                    <div class="search_product">
                        <span>Hãng</span>
                        <asp:DropDownList ID="search_vendor" runat="server" AutoPostBack="true" OnSelectedIndexChanged="VendorSearch_SelectedIndexChanged">
                        </asp:DropDownList>

                    </div>
                    <div class="search_product hidden">
                        <input type="checkbox" id="search_advan" value="1">Tìm kiếm nâng cao
                    </div>
                    <div class="sort_product">
                        <span>Sắp xếp theo: </span>

                        <asp:DropDownList ID="PriceOrders" runat="server" AutoPostBack="true" OnSelectedIndexChanged="PriceOrders_SelectedIndexChanged">
                            <asp:ListItem Value="0">Giá tăng dần</asp:ListItem>
                            <asp:ListItem Value="1">Giá giảm dần</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="space"></div>


                <asp:ListView ID="Category" runat="server"
                    DataKeyNames="ProductID" GroupItemCount="8"
                    ItemType="DoAnCuoiKy.Product"
                    OnPagePropertiesChanging="Category_PagePropertiesChanging">
                    <EmptyDataTemplate>
                        <div>Không tìm thấy sản phẩm.</div>
                    </EmptyDataTemplate>
                    <GroupTemplate>
                        <div id="itemPlaceholderContainer" runat="server">
                            <div id="itemPlaceholder" runat="server"></div>
                        </div>

                    </GroupTemplate>
                    <ItemTemplate>
                        <div runat="server">
                            <div class="col-lg-3 col-md-3 col-xs-12 col-sm-3 ProductItem mgr">
                                <div class="ProductImage QuickView">
                                    <a href="Product.aspx?ProductID=<%#Item.ProductID %>">
                                        <img src="/style/image/<%#:Item.ImagePath1%>" /></a>
                                </div>
                                <div class="ProductInfo">
                                    <div class="ProductDetails">
                                        <strong><a href="Product.aspx?ProductID=<%#Item.ProductID %>"><%#:Item.ProductName%></a></strong><br />


                                        <span class="SalePrice"><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.Price) %></span>
                                        <span class='<%# Item.onSale== false? "hidden" : "line_th"%>'><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.oldPrice) %></span>


                                        <p class="description"><%#:Item.Description%></p>
                                    </div>
                                    <div class="ProductActionAdd">
                                        <a href="/AddToCart.aspx?productID=<%#:Item.ProductID %>" class="" title="Thêm vào giỏ hàng">Thêm vào giỏ hàng</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                    <LayoutTemplate>


                        <div class="ProductList">
                            <div id="groupPlaceholderContainer" runat="server">
                                <div id="groupPlaceholder" runat="server"></div>
                            </div>
                        </div>

                    </LayoutTemplate>
                </asp:ListView>

                <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 text-center pager">
                    <asp:DataPager ID="ProductListPagerCombo" runat="server"
                        PagedControlID="Category" PageSize="2">
                        <Fields>
                            <asp:NumericPagerField ButtonType="Button" />
                        </Fields>
                    </asp:DataPager>
                </div>

            </div>

            <div class="Left col-md-2 clearfix">
                <div class="CategoryList">
                    <h2>Sản phẩm nổi bật</h2>
                    <div>
                        <ul class="category-list">

                            <asp:Repeater ID="right_pro_feat" runat="server" ItemType="DoAnCuoiKy.Product">
                                <ItemTemplate>
                                    <li>
                                        <div class="ProductImage QuickView">
                                            <a href="Product.aspx?ProductID=<%#Item.ProductID %>">
                                                <img src="/style/image/<%#Item.ImagePath1%>" /></a>
                                        </div>
                                        <div class="ProductInfo_2">
                                            <div class="ProductDetails_2">
                                                <strong><a href="Product.aspx?ProductID=<%#Item.ProductID %>"><%#Item.ProductName%></a></strong>
                                                <p class="SalePrice"><%#:String.Format(System.Globalization.CultureInfo.GetCultureInfo("vi-VN"),"{0:c}", Item.Price)%></p>
                                            </div>
                                        </div>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>

                        </ul>
                    </div>
                </div>
                <div class="CategoryList">
                    <h2>Sản phẩm giảm giá</h2>
                    <div>
                        <ul class="category-list">

                            <asp:Repeater ID="right_pro_new" runat="server" ItemType="DoAnCuoiKy.Product">
                                <ItemTemplate>
                                    <li>
                                        <div class="ProductImage QuickView">
                                            <a href="Product.aspx?ProductID=<%#Item.ProductID %>">
                                                <img src="/style/image/<%#Item.ImagePath1%>" /></a>
                                        </div>
                                        <div class="ProductInfo_2">
                                            <div class="ProductDetails_2">
                                                <strong><a href="Product.aspx?ProductID=<%#Item.ProductID %>"><%#Item.ProductName%></a></strong>
                                                <p class="SalePrice"><%#:String.Format(System.Globalization.CultureInfo.GetCultureInfo("vi-VN"),"{0:c}", Item.Price)%></p>
                                            </div>
                                        </div>
                                    </li>
                                </ItemTemplate>

                            </asp:Repeater>

                        </ul>
                    </div>
                </div>
            </div>

        </div>
        <div class="clearfix"></div>
    </div>
</asp:Content>
