<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GridViewCrud.aspx.cs" Inherits="GridViewExample.GridViewCrud" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Form Example</title>
    <link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .container-custom {
            margin-top: 50px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .btn-custom {
            margin: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container container-custom">
            <h2 class="text-center mb-4">Customer Information</h2>
            <div class="form-group row">
                <label for="txtFName" class="col-md-2 col-form-label">Name</label>
                <div class="col-md-10">
                    <asp:TextBox CssClass="form-control" ID="txtName" runat="server"></asp:TextBox>
                </div>
            </div>

            <label></label>

            <div class="form-group row">
                <label for="txtLName" class="col-md-2 col-form-label">Address</label>
                <div class="col-md-10">
                    <asp:TextBox CssClass="form-control" ID="txtAddress" runat="server"></asp:TextBox>
                </div>
            </div>

            <label></label>

            <div class="form-group row">
                <label for="txtEmail" class="col-md-2 col-form-label">City</label>
                <div class="col-md-10">
                    <asp:TextBox CssClass="form-control" ID="txtCity" runat="server"></asp:TextBox>
                </div>
            </div>

            <label></label>

            <div class="form-group row">
                <label for="txtAddress" class="col-md-2 col-form-label">Postal Code</label>
                <div class="col-md-10">
                    <asp:TextBox CssClass="form-control" ID="txtPostal" runat="server"></asp:TextBox>
                </div>
            </div>

            <label></label>

            <div class="form-group row">
                <label for="txtAddress" class="col-md-2 col-form-label">Phone No</label>
                <div class="col-md-10">
                    <asp:TextBox CssClass="form-control" ID="txtPhone" runat="server"></asp:TextBox>
                </div>
            </div>

            <label></label>

            <div class="form-group row">
                <div class="col-md-10 offset-md-2">
                    <asp:Button CssClass="btn btn-primary btn-custom" ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                    <asp:Button CssClass="btn btn-secondary btn-custom" ID="btnClear" runat="server" Text="Clear" />
                </div>
            </div>
            <br />

            <asp:Label CssClass="text-danger" ID="lblmsg" runat="server"></asp:Label>
        </div>

        <div class="container mt-5">
            <asp:GridView ID="custGrid" runat="server" CssClass="table"
                OnRowDeleting="custGrid_RowDeleting"
                OnRowEditing="custGrid_RowEditing"
                OnRowUpdating="custGrid_RowUpdating"
                OnRowCancelingEdit="custGrid_RowCancelingEdit"
                DataKeyNames="CustomerID"
                AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField HeaderText="Customer Id" DataField="CustomerID" ReadOnly="true" />

                    <asp:TemplateField HeaderText="Customer Name">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("CustomerName") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("CustomerName") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Address">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtAddress" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="City">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("City") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCity" runat="server" Text='<%# Bind("City") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Postal Code">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("PostalCode") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPostal" runat="server" Text='<%# Bind("PostalCode") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Phone No.">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("PhoneNo") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPhone" runat="server" Text='<%# Bind("PhoneNo") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:CommandField ShowEditButton="true"
                        ShowDeleteButton="true"
                        ControlStyle-CssClass="d-inline"
                        ButtonType="Image"
                        EditImageUrl="~/Icons/edit.png"
                        UpdateImageUrl="~/Icons/ok.png"
                        CancelImageUrl="~/Icons/cancel.png"
                        DeleteImageUrl="~/Icons/delete.png"
                        ControlStyle-Width="20px"
                        ControlStyle-Height="20px" />

                    <%--<asp:CommandField ShowDeleteButton="true"
                        ButtonType="Image"
                        DeleteImageUrl="~/Icons/delete.png"
                        ControlStyle-Width="20px"
                        ControlStyle-Height="20px" />--%>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
