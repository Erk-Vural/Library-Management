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
    public partial class book_rental : Form
    {
        public book_rental()
        {
            InitializeComponent();
        }

        private void rentalBindingNavigatorSaveItem_Click(object sender, EventArgs e)
        {
            this.Validate();
            this.rentalBindingSource.EndEdit();
            this.tableAdapterManager.UpdateAll(this.librarymanagementDataSet);

        }

        private void book_rental_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'librarymanagementDataSet.inventory' table. You can move, or remove it, as needed.
            this.inventoryTableAdapter.Fill(this.librarymanagementDataSet.inventory);
            // TODO: This line of code loads data into the 'librarymanagementDataSet.payment' table. You can move, or remove it, as needed.
            this.paymentTableAdapter.Fill(this.librarymanagementDataSet.payment);
            // TODO: This line of code loads data into the 'librarymanagementDataSet.rental' table. You can move, or remove it, as needed.
            this.rentalTableAdapter.Fill(this.librarymanagementDataSet.rental);

        }

        private void Exit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
