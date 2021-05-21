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
    public partial class language : Form
    {
        public language()
        {
            InitializeComponent();
        }

        private void languageBindingNavigatorSaveItem_Click(object sender, EventArgs e)
        {
            this.Validate();
            this.languageBindingSource.EndEdit();
            this.tableAdapterManager.UpdateAll(this.librarymanagementDataSet);

        }

        private void language_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'librarymanagementDataSet.language' table. You can move, or remove it, as needed.
            this.languageTableAdapter.Fill(this.librarymanagementDataSet.language);

        }

        private void languageDataGridView_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
