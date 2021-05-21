using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace library
{
    public partial class category1 : Form
    {
        private string connstring = String.Format("Server={0};Port={1};" +
            "User Id={2};Password={3};Database={4};",
            "localhost", 5432, "postgres",
            "password", "librarymanagement");

        private NpgsqlConnection conn;
        private string sql;
        private NpgsqlCommand cmd;
        private DataTable dt;


        private new void Select()
        {
            try
            {
                conn.Open();
                sql = "select * from category";
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

        public category1()
        {
            InitializeComponent();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            textBox1.Text = dataGridView1.CurrentRow.Cells[0].Value.ToString();
            textBox2.Text = dataGridView1.CurrentRow.Cells[1].Value.ToString();      
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

       
        private void button3_Click(object sender, EventArgs e)
        {
            
            string sorgu = "UPDATE category SET name=name WHERE category.category_id=id";
            cmd = new NpgsqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("id", Convert.ToInt32(textBox2.Text));
            cmd.Parameters.AddWithValue("name", textBox1.Text);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            Select();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string sql = "DELETE FROM category WHERE category_id=id";
            cmd = new NpgsqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("id", Convert.ToInt32(textBox2.Text));
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            Select();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string sql = "insert into category(category.name, category_id) values(name, id)";
            cmd = new NpgsqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("name", textBox1.Text);
            cmd.Parameters.AddWithValue("id", Convert.ToInt32(textBox2.Text));
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            Select();
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void category1_Load(object sender, EventArgs e)
        {
            conn = new NpgsqlConnection(connstring);
            Select();
        }


        private void textBox1_TextChanged_1(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged_1(object sender, EventArgs e)
        {

        }
    }
}
