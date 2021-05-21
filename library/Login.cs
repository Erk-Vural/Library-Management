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
    public partial class Login : Form
    {
        private string connstring = String.Format("Server={0};Port={1};" +
            "User Id={2};Password={3};Database={4};",
            "localhost", 5432, "postgres",
            "password", "librarymanagement");

        private NpgsqlConnection conn;
        private NpgsqlCommand cmd;
       

        public Login()
        {
            
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //this.Hide();
            //new mainMenu().Show();
           
            
            try
            {
                conn.Open();
                string sql = @"select * from u_login(:_username, :_password)";
                cmd = new NpgsqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("_username", txtusername.Text);
                cmd.Parameters.AddWithValue("_password", textBox2.Text);

                int result = (int)cmd.ExecuteScalar();


                conn.Close();

                if (result == 1)
                {
                     this.Hide();
                     new mainMenu().Show();
                }else 
                {
                    MessageBox.Show("Invalid or wrong username or password","Login failed",MessageBoxButtons.OK,MessageBoxIcon.Asterisk);
                    return;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: "+ex.Message,"Something went wrong",MessageBoxButtons.OK,MessageBoxIcon.Error);
                conn.Close();
            }
            
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

       
        private void textBox2_TextChanged_1(object sender, EventArgs e)
        {

        }

        private void txtusername_TextChanged(object sender, EventArgs e)
        {

        }

        private void Login_Load_1(object sender, EventArgs e)
        {
            conn = new NpgsqlConnection(connstring);
        }
    }
}
