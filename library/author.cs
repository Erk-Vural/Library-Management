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
    public partial class author : Form
    {
        public author()
        {
            InitializeComponent();
        }

        private void author_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'librarymanagementDataSet.author_info' table. You can move, or remove it, as needed.
            this.author_infoTableAdapter.Fill(this.librarymanagementDataSet.author_info);

        }
    }
}
