using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace library
{
    public partial class account : Form
    {
        private string connstring = String.Format("Server={0};Port={1};" +
            "User Id={2};Password={3};Database={4};",
            "localhost", 5432, "postgres",
            "password", "librarymanagement");

        private NpgsqlConnection conn;
        private string sql;
        private NpgsqlCommand cmd;
        private DataTable dt;
        private int rowIndex = -1;
        public account()
        {
            InitializeComponent();
        }

        private void accountBindingNavigatorSaveItem_Click(object sender, EventArgs e)
        {
            this.Validate();
            this.accountBindingSource.EndEdit();
            this.tableAdapterManager.UpdateAll(this.librarymanagementDataSet);

        }

        private void account_Load(object sender, EventArgs e)
        {
         
            conn = new NpgsqlConnection(connstring);
            Select();
        }
        private new void Select()
        {
            try
            {
                conn.Open();
                sql = @"select * from me_select()";
                cmd = new NpgsqlCommand(sql, conn);
                dt = new DataTable();
                dt.Load(cmd.ExecuteReader());               
                conn.Close();
                dataGridView1.DataSource = null;
                dataGridView1.DataSource = dt;

            }
            catch (Exception ex)
            {
                conn.Close();
                MessageBox.Show("Error" + ex.Message);

            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            rowIndex = -1;
            account_idTextBox.Enabled=first_nameTextBox.Enabled = last_nameTextBox.Enabled = e_mailTextBox.Enabled = address_idTextBox.Enabled = true;
            account_idTextBox.Text=first_nameTextBox.Text = last_nameTextBox.Text = e_mailTextBox.Text = address_idTextBox.Text = null;
            account_idTextBox.Select();

        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (rowIndex < 0)
            {
                MessageBox.Show("Please choose member to delete");
                return;
            }
            try
            {
                conn.Open();
                sql = @"select * from me_delete(:_account_id)";
                cmd = new NpgsqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("_account_id", Convert.ToInt32(dataGridView1.Rows[rowIndex].Cells[0].Value.ToString()));
                if ((int)cmd.ExecuteScalar() == 1)
                {
                    MessageBox.Show("Delete member successfully");
                    rowIndex = -1;
                    Select();
                }
                conn.Close();
            }
            catch (Exception ex)
            {
                conn.Close();
                MessageBox.Show("Delete fail. Error: " + ex.Message);

            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (rowIndex < 0)
            {
                MessageBox.Show("Please choose member to update");
                return;
            }
        }

        private void save_Click(object sender, EventArgs e)
        {
            int result = 0;
            if (rowIndex < 0)//Insert
            {
                try
                {
                    conn.Open();
                    sql = @"select * from me_insert( _first_name, _last_name, _email, _address_id)";
                    cmd = new NpgsqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("_first_name", first_nameTextBox.Text);
                    cmd.Parameters.AddWithValue("_last_name", last_nameTextBox.Text);
                    cmd.Parameters.AddWithValue("_email", e_mailTextBox.Text);
                    cmd.Parameters.AddWithValue("_address_id", Convert.ToInt16(address_idTextBox.Text));
                    result = (int)cmd.ExecuteScalar();
                    conn.Close();
                    if (result == 1)
                    {
                        MessageBox.Show("Inserted new member successfully ");
                        Select();
                    }
                    else
                    {
                        MessageBox.Show("Inserted fail");
                    }

                }
                catch (Exception ex)
                {
                    conn.Close();
                    MessageBox.Show("Inserted fail. Error: " + ex.Message);
                }
            }
            else//update
            {
                try
                {
                    conn.Open();
                    sql = @"select * from me_update(:_account_id, :_first_name, :_last_name, :_email, :_address_id)";
                    cmd = new NpgsqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("_account_id", Convert.ToInt32(dataGridView1.Rows[rowIndex].Cells["account_id"].Value.ToString()));
                    cmd.Parameters.AddWithValue("_first_name", first_nameTextBox.Text);
                    cmd.Parameters.AddWithValue("_last_name", last_nameTextBox.Text);
                    cmd.Parameters.AddWithValue("_email", e_mailTextBox.Text);
                    cmd.Parameters.AddWithValue("_address_id", Convert.ToInt16(address_idTextBox.Text));
                    result = (int)cmd.ExecuteScalar();
                    conn.Close();
                    if (result == 1)
                    {
                        MessageBox.Show("Updated successfully ");
                        Select();
                    }
                    else
                    {
                        MessageBox.Show("Updated fail");
                    }
                }
                catch (Exception ex)
                {
                    conn.Close();
                    MessageBox.Show("Updated fail. Error: " + ex.Message);
                }
                result = 0;
                account_idTextBox.Text = first_nameTextBox.Text = last_nameTextBox.Text = e_mailTextBox.Text = address_idTextBox.Text = null;
                account_idTextBox.Enabled = first_nameTextBox.Enabled = last_nameTextBox.Enabled = e_mailTextBox.Enabled = address_idTextBox.Enabled = false;
            }
        }

        private void account_idLabel_Click(object sender, EventArgs e)
        {

        }

        private void account_idTextBox_TextChanged(object sender, EventArgs e)
        {

        }

       

        private void e_mailTextBox_TextChanged(object sender, EventArgs e)
        {

        }

        private void Exit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if(e.RowIndex>=0)
            {
                rowIndex = e.RowIndex;
                account_idTextBox.Text = dataGridView1.Rows[e.RowIndex].Cells[0].Value.ToString();
                first_nameTextBox.Text = dataGridView1.Rows[e.RowIndex].Cells[1].Value.ToString();
                last_nameTextBox.Text = dataGridView1.Rows[e.RowIndex].Cells[2].Value.ToString();
                e_mailTextBox.Text = dataGridView1.Rows[e.RowIndex].Cells[3].Value.ToString();
                address_idTextBox.Text = dataGridView1.Rows[e.RowIndex].Cells[4].Value.ToString();

            }
        }

        private void first_nameTextBox_TextChanged(object sender, EventArgs e)
        {
       
        }

        private void address_idTextBox_TextChanged(object sender, EventArgs e)
        {

        }
    }
}