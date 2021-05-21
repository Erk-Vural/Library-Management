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
    public partial class account_list : Form
    {
        public account_list()
        {
            InitializeComponent();
        }

        private void account_list_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'librarymanagementDataSet.member_list' table. You can move, or remove it, as needed.
            this.member_listTableAdapter.Fill(this.librarymanagementDataSet.member_list);

        }
    }
}
