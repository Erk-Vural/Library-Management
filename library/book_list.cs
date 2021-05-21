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
    public partial class book_list : Form
    {
        public book_list()
        {
            InitializeComponent();
        }

        private void book_list_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'librarymanagementDataSet.book' table. You can move, or remove it, as needed.
            this.bookTableAdapter.Fill(this.librarymanagementDataSet.book);
            // TODO: This line of code loads data into the 'librarymanagementDataSet.book_list' table. You can move, or remove it, as needed.
            this.book_listTableAdapter.Fill(this.librarymanagementDataSet.book_list);

        }
    }
}
