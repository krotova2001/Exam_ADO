using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Exam_ADO
{
    public partial class Form2 : Form
    {
        internal Model1Container db;
        public Form2(Model1Container d)
        {
            InitializeComponent();
        }
        
        /// <summary>
        /// В контруктторе передаем то что нужно редактировать
        /// </summary>
        /// <param name="d"></param>
        /// <param name="choise"></param>
        /// 
        public Form2(Model1Container d, int choise)
        {
            InitializeComponent();
            db = d;
            switch (choise)
            {
                case 0: // пользователи
                    dataGridView1.DataSource = db.UsersSet.ToList();
                    break;
                    //авторы
                case 1: dataGridView1.DataSource = db.AuthorsSet.ToList();
                    break;
                    //издатели
                case 2: dataGridView1.DataSource = db.PublisherSet.ToList();
                    break;
                    //жанры
                case 3: dataGridView1.DataSource = db.GenreSet.ToList();
                    break;
            }
        }


        private void Form2_Load(object sender, EventArgs e)
        {

        }

        private void bindingSource1_CurrentChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            db.SaveChanges();
            this.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
