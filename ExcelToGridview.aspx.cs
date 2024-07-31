using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GridViewExample
{
    public partial class ExcelToGridview : System.Web.UI.Page
    {
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            string fullPath = System.IO.Path.Combine(Server.MapPath("~/Files"), excelFile.PostedFile.FileName);

            excelFile.PostedFile.SaveAs(fullPath);

            string cs = string.Format("Provider = Microsoft.ACE.OLEDB.12.0; Data Source = {0}; Extended Properties = \"Excel 12.0 Xml;HDR=Yes;IMEX=1\";", fullPath);

            OleDbConnection con = new OleDbConnection(cs);

            try
            {
                OleDbCommand cmd = new OleDbCommand("Select * from [Sheet1$]", con);

                //con.Open();
                //custGrid.DataSource = cmd.ExecuteReader();
                //custGrid.DataBind();
                //con.Close();

                OleDbDataAdapter da = new OleDbDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    if (ViewState["table"] == null)
                    {
                        ViewState["table"] = dt;
                        custGrid.DataSource = dt;
                        custGrid.DataBind();
                        btnSubmit.Visible = true;
                    }
                }
                else
                {
                    btnSubmit.Visible = false;
                }

            }
            catch
            {
                con.Close();
            }
        }

        protected void custGrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            if (ViewState["table"] != null)
            {
                dt = (DataTable)ViewState["table"];
                custGrid.EditIndex = e.NewEditIndex;
                custGrid.DataSource = dt;
                custGrid.DataBind();
            }
        }

        protected void custGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            if (ViewState["table"] != null)
            {
                dt = (DataTable)ViewState["table"];
                custGrid.EditIndex = -1;
                custGrid.DataSource = dt;
                custGrid.DataBind();
            }
        }

        protected void custGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            if (ViewState["table"] != null)
            {
                DataTable dt = (DataTable)ViewState["table"];
                DataRow row = dt.Rows[e.RowIndex];

                try
                {
                    row["FirstName"] = GetControlValue(custGrid, e.RowIndex, "txtfName");
                    row["LastName"] = GetControlValue(custGrid, e.RowIndex, "txtlName");
                    row["Email"] = GetControlValue(custGrid, e.RowIndex, "txtEmail");
                    row["Address"] = GetControlValue(custGrid, e.RowIndex, "txtAddress");

                    dt.AcceptChanges();
                    ViewState["table"] = dt;

                    custGrid.EditIndex = -1;
                    custGrid.DataSource = dt;
                    custGrid.DataBind();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("An error occurred: " + ex.Message);
                }
            }
        }

        private string GetControlValue(GridView grid, int rowIndex, string controlId)
        {
            GridViewRow row = grid.Rows[rowIndex];
            TextBox textBox = (TextBox)row.FindControl(controlId);

            if (textBox != null)
            {
                return textBox.Text;
            }
            else
            {
                throw new InvalidOperationException($"TextBox with ID '{controlId}' not found in row {rowIndex}.");
            }
        }

        protected void custGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (ViewState["table"] != null)
            {
                DataTable dt = (DataTable)ViewState["table"];

                try
                {
                    dt.Rows[e.RowIndex].Delete();
                    dt.AcceptChanges();
                    ViewState["table"] = dt;

                    if (dt.Rows.Count > 0)
                    {
                        btnSubmit.Visible = true;
                    }
                    else
                    {
                        ViewState["table"] = null;
                        btnSubmit.Visible = false;
                    }

                    custGrid.DataSource = dt;
                    custGrid.DataBind();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("An error occurred: " + ex.Message);
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

        }
    }
}