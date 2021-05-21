namespace library
{
    partial class rents_by_library
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
            this.rentsbylibraryBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.librarymanagementDataSet = new library.librarymanagementDataSet();
            this.rentsbybookcategoryBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.rents_by_book_categoryTableAdapter = new library.librarymanagementDataSetTableAdapters.rents_by_book_categoryTableAdapter();
            this.rents_by_libraryTableAdapter = new library.librarymanagementDataSetTableAdapters.rents_by_libraryTableAdapter();
            this.tableAdapterManager = new library.librarymanagementDataSetTableAdapters.TableAdapterManager();
            this.rents_by_libraryDataGridView = new System.Windows.Forms.DataGridView();
            this.dataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn2 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.rentsbylibraryBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.librarymanagementDataSet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.rentsbybookcategoryBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.rents_by_libraryDataGridView)).BeginInit();
            this.SuspendLayout();
            // 
            // rentsbylibraryBindingSource
            // 
            this.rentsbylibraryBindingSource.DataMember = "rents_by_library";
            this.rentsbylibraryBindingSource.DataSource = this.librarymanagementDataSet;
            // 
            // librarymanagementDataSet
            // 
            this.librarymanagementDataSet.DataSetName = "librarymanagementDataSet";
            this.librarymanagementDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // rentsbybookcategoryBindingSource
            // 
            this.rentsbybookcategoryBindingSource.DataMember = "rents_by_book_category";
            this.rentsbybookcategoryBindingSource.DataSource = this.librarymanagementDataSet;
            // 
            // rents_by_book_categoryTableAdapter
            // 
            this.rents_by_book_categoryTableAdapter.ClearBeforeFill = true;
            // 
            // rents_by_libraryTableAdapter
            // 
            this.rents_by_libraryTableAdapter.ClearBeforeFill = true;
            // 
            // tableAdapterManager
            // 
            this.tableAdapterManager.accountTableAdapter = null;
            this.tableAdapterManager.addressTableAdapter = null;
            this.tableAdapterManager.authorTableAdapter = null;
            this.tableAdapterManager.BackupDataSetBeforeUpdate = false;
            this.tableAdapterManager.book_authorTableAdapter = null;
            this.tableAdapterManager.book_categoryTableAdapter = null;
            this.tableAdapterManager.bookTableAdapter = null;
            this.tableAdapterManager.categoryTableAdapter = null;
            this.tableAdapterManager.cityTableAdapter = null;
            this.tableAdapterManager.Connection = null;
            this.tableAdapterManager.countryTableAdapter = null;
            this.tableAdapterManager.inventoryTableAdapter = null;
            this.tableAdapterManager.languageTableAdapter = null;
            this.tableAdapterManager.librarianTableAdapter = null;
            this.tableAdapterManager.libraryTableAdapter = null;
            this.tableAdapterManager.memberTableAdapter = null;
            this.tableAdapterManager.paymentTableAdapter = null;
            this.tableAdapterManager.rentalTableAdapter = null;
            this.tableAdapterManager.UpdateOrder = library.librarymanagementDataSetTableAdapters.TableAdapterManager.UpdateOrderOption.InsertUpdateDelete;
            // 
            // rents_by_libraryDataGridView
            // 
            this.rents_by_libraryDataGridView.AutoGenerateColumns = false;
            this.rents_by_libraryDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.rents_by_libraryDataGridView.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.dataGridViewTextBoxColumn1,
            this.dataGridViewTextBoxColumn2});
            this.rents_by_libraryDataGridView.DataSource = this.rentsbylibraryBindingSource;
            this.rents_by_libraryDataGridView.Location = new System.Drawing.Point(1, 1);
            this.rents_by_libraryDataGridView.Name = "rents_by_libraryDataGridView";
            this.rents_by_libraryDataGridView.Size = new System.Drawing.Size(244, 434);
            this.rents_by_libraryDataGridView.TabIndex = 0;
            // 
            // dataGridViewTextBoxColumn1
            // 
            this.dataGridViewTextBoxColumn1.DataPropertyName = "store";
            this.dataGridViewTextBoxColumn1.HeaderText = "store";
            this.dataGridViewTextBoxColumn1.Name = "dataGridViewTextBoxColumn1";
            // 
            // dataGridViewTextBoxColumn2
            // 
            this.dataGridViewTextBoxColumn2.DataPropertyName = "total_rents";
            this.dataGridViewTextBoxColumn2.HeaderText = "total_rents";
            this.dataGridViewTextBoxColumn2.Name = "dataGridViewTextBoxColumn2";
            // 
            // rents_by_library
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(247, 435);
            this.Controls.Add(this.rents_by_libraryDataGridView);
            this.Name = "rents_by_library";
            this.Text = "rents_by_library";
            this.Load += new System.EventHandler(this.rents_by_library_Load);
            ((System.ComponentModel.ISupportInitialize)(this.rentsbylibraryBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.librarymanagementDataSet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.rentsbybookcategoryBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.rents_by_libraryDataGridView)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion
        private librarymanagementDataSet librarymanagementDataSet;
        private System.Windows.Forms.BindingSource rentsbybookcategoryBindingSource;
        private librarymanagementDataSetTableAdapters.rents_by_book_categoryTableAdapter rents_by_book_categoryTableAdapter;
        private System.Windows.Forms.BindingSource rentsbylibraryBindingSource;
        private librarymanagementDataSetTableAdapters.rents_by_libraryTableAdapter rents_by_libraryTableAdapter;
        private librarymanagementDataSetTableAdapters.TableAdapterManager tableAdapterManager;
        private System.Windows.Forms.DataGridView rents_by_libraryDataGridView;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn2;
    }
}