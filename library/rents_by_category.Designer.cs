namespace library
{
    partial class rents_by_category
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.categoryDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.totalrentsDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.rentsbybookcategoryBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.librarymanagementDataSet = new library.librarymanagementDataSet();
            this.rents_by_book_categoryTableAdapter = new library.librarymanagementDataSetTableAdapters.rents_by_book_categoryTableAdapter();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.rentsbybookcategoryBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.librarymanagementDataSet)).BeginInit();
            this.SuspendLayout();
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToAddRows = false;
            this.dataGridView1.AllowUserToDeleteRows = false;
            this.dataGridView1.AutoGenerateColumns = false;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.categoryDataGridViewTextBoxColumn,
            this.totalrentsDataGridViewTextBoxColumn});
            this.dataGridView1.DataSource = this.rentsbybookcategoryBindingSource;
            this.dataGridView1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataGridView1.Location = new System.Drawing.Point(0, 0);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.ReadOnly = true;
            this.dataGridView1.Size = new System.Drawing.Size(237, 422);
            this.dataGridView1.TabIndex = 0;
            // 
            // categoryDataGridViewTextBoxColumn
            // 
            this.categoryDataGridViewTextBoxColumn.DataPropertyName = "category";
            this.categoryDataGridViewTextBoxColumn.HeaderText = "category";
            this.categoryDataGridViewTextBoxColumn.Name = "categoryDataGridViewTextBoxColumn";
            this.categoryDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // totalrentsDataGridViewTextBoxColumn
            // 
            this.totalrentsDataGridViewTextBoxColumn.DataPropertyName = "total_rents";
            this.totalrentsDataGridViewTextBoxColumn.HeaderText = "total_rents";
            this.totalrentsDataGridViewTextBoxColumn.Name = "totalrentsDataGridViewTextBoxColumn";
            this.totalrentsDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // rentsbybookcategoryBindingSource
            // 
            this.rentsbybookcategoryBindingSource.DataMember = "rents_by_book_category";
            this.rentsbybookcategoryBindingSource.DataSource = this.librarymanagementDataSet;
            // 
            // librarymanagementDataSet
            // 
            this.librarymanagementDataSet.DataSetName = "librarymanagementDataSet";
            this.librarymanagementDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // rents_by_book_categoryTableAdapter
            // 
            this.rents_by_book_categoryTableAdapter.ClearBeforeFill = true;
            // 
            // rents_by_category
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(237, 422);
            this.Controls.Add(this.dataGridView1);
            this.Name = "rents_by_category";
            this.Text = "rents_by_category";
            this.Load += new System.EventHandler(this.rents_by_category_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.rentsbybookcategoryBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.librarymanagementDataSet)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView dataGridView1;
        private librarymanagementDataSet librarymanagementDataSet;
        private System.Windows.Forms.BindingSource rentsbybookcategoryBindingSource;
        private librarymanagementDataSetTableAdapters.rents_by_book_categoryTableAdapter rents_by_book_categoryTableAdapter;
        private System.Windows.Forms.DataGridViewTextBoxColumn categoryDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn totalrentsDataGridViewTextBoxColumn;
    }
}