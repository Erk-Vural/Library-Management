using library.librarymanagementDataSetTableAdapters;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace library
{
    public partial class mainMenu : Form
    {
        public mainMenu()
        {
            InitializeComponent();
        }

        private void checkedListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button6_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void button9_Click(object sender, EventArgs e)
        {
            new author().Show();
        }

        private void button10_Click(object sender, EventArgs e)
        {
            
        }

        private void button11_Click(object sender, EventArgs e)
        {
            new rents_by_library().Show();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            new rents_by_category().Show();
        }

        private void mainMenu_Load(object sender, EventArgs e)
        {

        }

        private void button7_Click(object sender, EventArgs e)
        {
            new language().Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            new category1().Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
           new account().Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            new book_rental().Show();
        }

        private void button9_Click_1(object sender, EventArgs e)
        {
            new book_list().Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            new account_list().Show();
        }
    }
}
