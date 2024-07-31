using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace GridViewExample
{
    public partial class GridViewCrud : System.Web.UI.Page
    {
        private SqlConnection con;
        private void connection()
        {
            string constring = ConfigurationManager.ConnectionStrings["customerConn"].ToString();
            con = new SqlConnection(constring);
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetData();
            }
        }

        private void GetData()
        {
            connection();

            SqlCommand cmd = new SqlCommand("[dbo].[spGet_Customer_Data]", con);
            cmd.CommandType = CommandType.StoredProcedure;

            con.Open();
            custGrid.DataSource = cmd.ExecuteReader();
            custGrid.DataBind();
            con.Close();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                connection();

                string Name = txtName.Text;
                string Address = txtAddress.Text;
                string City = txtCity.Text;
                string Postal = Convert.ToString(txtPostal.Text);
                string Phone = Convert.ToString(txtPhone.Text);

                SqlCommand cmd = new SqlCommand("[dbo].[spInsert_Customer]", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@CustomerName", Name);
                cmd.Parameters.AddWithValue("@Address", Address);
                cmd.Parameters.AddWithValue("@City", City);
                cmd.Parameters.AddWithValue("@PostalCode", Postal);
                cmd.Parameters.AddWithValue("@PhoneNo", Phone);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                lblmsg.Text = "Record Added!...";

                txtName.Text = "";
                txtAddress.Text = "";
                txtCity.Text = "";
                txtPostal.Text = "";
                txtPhone.Text = "";
            }
            catch
            {
                lblmsg.Text = "Failed!...";
                con.Close();
            }
        }

        protected void custGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                connection();

                int id = Convert.ToInt32(custGrid.DataKeys[e.RowIndex].Value);

                SqlCommand cmd = new SqlCommand("[dbo].[spDelete_Customer]", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Customer_ID", id);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Record deleted successfully.');", true);

                GetData();
            }
            catch
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error occurred while deleting the record.');", true);
            }
        }

        protected void custGrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            custGrid.EditIndex = e.NewEditIndex;
            GetData();
        }

        protected void custGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            custGrid.EditIndex = -1;
            GetData();
        }

        protected void custGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                connection();

                int id = Convert.ToInt32(custGrid.DataKeys[e.RowIndex].Value);
                string Name = (custGrid.Rows[e.RowIndex].FindControl("txtName") as TextBox).Text;
                string Address = (custGrid.Rows[e.RowIndex].FindControl("txtAddress") as TextBox).Text;
                string City = (custGrid.Rows[e.RowIndex].FindControl("txtCity") as TextBox).Text;
                string Postal = Convert.ToString((custGrid.Rows[e.RowIndex].FindControl("txtPostal") as TextBox).Text);
                string Phone = Convert.ToString((custGrid.Rows[e.RowIndex].FindControl("txtPhone") as TextBox).Text);

                SqlCommand cmd = new SqlCommand("[dbo].[spUpdate_Customer]", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Customer_ID", id);
                cmd.Parameters.AddWithValue("@CustomerName", Name);
                cmd.Parameters.AddWithValue("@Address", Address);
                cmd.Parameters.AddWithValue("@City", City);
                cmd.Parameters.AddWithValue("@PostalCode", Postal);
                cmd.Parameters.AddWithValue("@PhoneNo", Phone);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Record Updated successfully.');", true);

                custGrid.EditIndex = -1;
                GetData();
            }
            catch
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error While Updating Data.');", true);
                con.Close();
                GetData();
            }
        }
    }
}