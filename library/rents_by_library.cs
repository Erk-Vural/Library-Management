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
    public partial class rents_by_library : Form
    {
        public rents_by_library()
        {
            InitializeComponent();
        }

        private void rents_by_library_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'librarymanagementDataSet.rents_by_library' table. You can move, or remove it, as needed.
            this.rents_by_libraryTableAdapter.Fill(this.librarymanagementDataSet.rents_by_library);
            // TODO: This line of code loads data into the 'librarymanagementDataSet.rents_by_book_category' table. You can move, or remove it, as needed.
            this.rents_by_book_categoryTableAdapter.Fill(this.librarymanagementDataSet.rents_by_book_category);

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
