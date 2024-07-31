<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExcelToGridview.aspx.cs" Inherits="GridViewExample.ExcelToGridview" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        .container-custom {
            margin-top: 50px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        #excelFile {
            margin-left: 50px;
            width: 400px;
        }

        #btnUpload {
            width: 150px;
            margin-left: -100px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="container container-custom">
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div class="col-md-8">
                        <asp:FileUpload ID="excelFile" runat="server" CssClass="form-control" />
                    </div>
                </div>
                <div class="col-md-4">
                    <asp:Button ID="btnUpload" runat="server" Text="Upload"
                        CssClass="btn btn-success btn-block"
                        OnClick="btnUpload_Click" />
                </div>
            </div>

            <hr />
            <br />

            <div class="container container-custom mt-3">
                <asp:Button CssClass="btn btn-success" runat="server" ID="btnSubmit" Text="Submit" Visible="false" OnClick="btnSubmit_Click" />
                <asp:Label ID="lblmsg" CssClass="text-success" runat="server"></asp:Label>
                <br />
                <br />
                <asp:GridView ID="custGrid" runat="server" CssClass="table"
                    AutoGenerateColumns="false"
                    OnRowEditing="custGrid_RowEditing"
                    OnRowCancelingEdit="custGrid_RowCancelingEdit"
                    OnRowUpdating="custGrid_RowUpdating"
                    OnRowDeleting="custGrid_RowDeleting" >
                    <Columns>
                        <asp:BoundField HeaderText="Customer Id" DataField="CustomerId" ReadOnly="true" />

                        <asp:TemplateField HeaderText="First Name">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("FirstName") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtfName" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Last Name">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("LastName") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtlName" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Email Id">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>'></asp:TextBox>
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

                        <asp:CommandField HeaderText="Action" ShowEditButton="true"
                            ShowDeleteButton="true"
                            ButtonType="Image"
                            EditImageUrl="~/Icons/edit.png"
                            DeleteImageUrl="~/Icons/delete.png"
                            UpdateImageUrl="~/Icons/ok.png"
                            CancelImageUrl="~/Icons/cancel.png"
                            ControlStyle-Width="20px"
                            ControlStyle-Height="20px" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
