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
    public partial class Form_Sell : Form
    {
        Model1Container db;
        Books book;
        List<Books> books;
        public Form_Sell()
        {
            InitializeComponent();
        }

        public Form_Sell(Model1Container d)
        {
            db = d;
            InitializeComponent();
            books = new List<Books>();
        }
        
        //выбор книги
        private void comboBox1_Click(object sender, EventArgs e)
        {
            comboBox1.Items.Clear();
            var b = db.BooksSet.ToList();
            foreach (var i in b)
            {
                comboBox1.Items.Add(i.Title);
            }
        }
        
        //кнопка Добавить
        private void button1_Click(object sender, EventArgs e)
        {
            if (numericUpDown1.Value > 0)
            {
                listBox1.Items.Add(book.Title + "-" + numericUpDown1.Value.ToString() + " шт.");
                books.Add(book);
                double price = 0.0;
                foreach (var b in books)
                    price += b.Cost;
                price *= Convert.ToDouble(numericUpDown1.Value);
                label13.Text = price.ToString();
                double discount = 0.0;
                foreach (var bookd in books)
                    discount += (bookd.Cost - (bookd.Cost / 100 * bookd.Akcii.Discount));
                double total = price - discount;
                label15.Text = total.ToString();
            }
        }

        //Очисить корзину
        private void button2_Click(object sender, EventArgs e)
        {
            listBox1.Items.Clear();
        }

        //выбор книги
        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            book = db.BooksSet.Where(ge => ge.Title == comboBox1.Text).FirstOrDefault();
            label10.Text = book.Cost.ToString();
            if (book.Akcii !=null)
            {
                label11.Text = book.Akcii.Discount.ToString();
                label12.Text = (book.Cost - (book.Cost / 100 * book.Akcii.Discount)).ToString();
            }
            else
            {
                label12.Text = label10.Text;
            }
               
        }

        private void Form_Sell_Load(object sender, EventArgs e)
        {

        }
    }
}
