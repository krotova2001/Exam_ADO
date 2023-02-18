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
    public partial class Form_akcii : Form
    {
        internal Model1Container db;
        Akcii current_ak; // текущая выбранная акция
        public Form_akcii()
        {
            InitializeComponent();
        }
        public Form_akcii(Model1Container d)
        {
            db = d;
            InitializeComponent();
            Akcii_update();
        }

        //Кнопка сохранить
        private void button1_Click(object sender, EventArgs e)
        {
            if (current_ak != null)
            {
                current_ak.Description = textBox1.Text;
                current_ak.Discount = Convert.ToInt32(numericUpDown1.Value);
                current_ak.start = DateTime.Parse(textBox2.Text);
                current_ak.stop = DateTime.Parse(textBox3.Text);
                db.SaveChanges();
                Akcii_update();
            }
        }

        //запонение полей при выборе акции
        private void fill_fields(Akcii a)
        {
            textBox1.Text = a.Description;
            textBox2.Text = a.start.ToShortDateString();
            textBox3.Text = a.start.ToShortDateString();
            numericUpDown1.Value = a.Discount;
        }

        public void Akcii_update()
        {
            listBox1.Items.Clear();
            var a = db.AkciiSet.ToList();
            foreach (var ak in a)
                listBox1.Items.Add(ak.Description);
        }

        //кнопка Добавить
        private void button3_Click(object sender, EventArgs e)
        {
            Akcii A = new Akcii();
            A.Description = textBox1.Text;
            A.Discount = Convert.ToInt32(numericUpDown1.Value);
            A.start = DateTime.Parse(textBox2.Text);
            A.stop = DateTime.Parse(textBox3.Text);
            db.AkciiSet.Add(A);
            db.SaveChanges();
            Akcii_update();
        }

        //Кнопка Удалить
        private void button2_Click(object sender, EventArgs e)
        {
            if (current_ak != null)
                db.AkciiSet.Remove(current_ak);
            db.SaveChanges();
            Akcii_update();
        }

        private void monthCalendar1_DateChanged(object sender, DateRangeEventArgs e)
        {
            textBox2.Text = monthCalendar1.SelectionStart.ToShortDateString();
            textBox3.Text = monthCalendar1.SelectionEnd.ToShortDateString();
        }

        //выбор текущей акции
        private void listBox1_Click(object sender, EventArgs e)
        {
            current_ak = db.AkciiSet.FirstOrDefault(x => x.Description == listBox1.SelectedItem.ToString());
            if (current_ak != null)
                fill_fields(current_ak);
        }
    }
}
