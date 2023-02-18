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
    public partial class Form1 : Form
    {
        User current_user; // текущий пользователь для авторизации
        Books cur_book; // текущая выбранная книга

        internal Model1Container db;
        public Form1()
        {
            InitializeComponent();
        }

        //обновление листбокса
        public void ls_update()
        {
            var books = db.BooksSet.ToList();
            listBox1.Items.Clear();
            foreach (var book in books)
                listBox1.Items.Add(book.Title);
        }

        //сохранение книги
        public void Save_book(Books book)
        {
            //заполнение простых свойств
            book.Title = textBox1.Text;
            book.Year = Convert.ToInt32(textBox3.Text);
            book.Cost = Convert.ToInt32(textBox4.Text);
            book.Cost_self = Convert.ToInt32(textBox5.Text);
            book.Pages = Convert.ToInt32(textBox6.Text);

            //выбор жанра
            Genre g = db.GenreSet.Where(ge => ge.Name == comboBox1.Text).FirstOrDefault();
            book.Genre = g;
            g.Books.Add(book);

            //выбор издательства
            Publisher publisher = db.PublisherSet.Where(p => p.Name == comboBox2.Text).FirstOrDefault();
            book.Publisher = publisher;
            publisher.Books.Add(book);

            //выбор акций
            Akcii ak = db.AkciiSet.Where(p => p.Description == comboBox4.Text).FirstOrDefault();
            if (ak != null)
            {
                book.Akcii = ak;
                ak.Books.Add(book);
            }

            //проверяем есть ли уже такой автор
            var au = from a in db.AuthorsSet
                        where a.Name == textBox2.Text
                        select a;
            
            if (au.Count() > 0)//если есть - ставим его в авторы книги
            {
                Authors authors = au.FirstOrDefault();
                book.Authors = authors;
                authors.Books.Add(book);
            }
            else
            {
                //если такого автора нет - делаем нового
                Authors author = new Authors();
                author.Name = textBox2.Text;
                db.AuthorsSet.Add(author);
                author.Books.Add(book);
                book.Authors = author;
            }
            
        }
            
        private void Form1_Load(object sender, EventArgs e)
        {
            //загружаем авторизацию
            Login login = new Login();
            if (login.ShowDialog() == DialogResult.Cancel)
                this.Close();
            current_user = login.Fill_user(); // передаем текущего пользователя
            this.Text = current_user.ToString(); // заголовок окна с текущим пользователем
            db = new Model1Container();
            ls_update(); // Обновить список
        }

        //кнопка Новая книга
        private void button5_Click(object sender, EventArgs e)
        {
            
            if (textBox1.Text.Length < 1 || textBox2.Text.Length < 1)
                MessageBox.Show("Все поля должны быть заполнены");
            else
            {
                {
                    //создаем новую книгу
                    Books book = new Books();
                    Save_book(book); // зполняем все поля
                    
                    db.BooksSet.Add(book);
                    db.SaveChanges();
                    ls_update();
                }
            }
        }

        //открытие списка жанров
        private void comboBox1_Click(object sender, EventArgs e)
        {
            comboBox1.Items.Clear();
            var Geners = db.GenreSet.ToList();
            foreach (var i in Geners)
            {
                comboBox1.Items.Add(i.Name);
            }
        }

        //открытие списка издательств
        private void comboBox2_Click(object sender, EventArgs e)
        {
            comboBox2.Items.Clear();
            var publishers = db.PublisherSet.ToList();
            foreach (var i in publishers)
            {
                comboBox2.Items.Add(i.Name);
            }
        }

        //выбор книги в списке
        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            cur_book = db.BooksSet.FirstOrDefault(x => x.Title == listBox1.SelectedItem.ToString());
            if (cur_book != null)
                fill_fields(cur_book);
        }

        //функция заполнения полей выбранной книги
        public void fill_fields(Books b)
        {
            label11.Text = "";
            textBox1.Text = b.Title;
            textBox2.Text = b.Authors.Name;
            textBox3.Text = b.Year.ToString();
            textBox4.Text = b.Cost.ToString();
            textBox5.Text = b.Cost_self.ToString();
            textBox6.Text = b.Pages.ToString();
            comboBox1.Text = b.Genre.Name;
            comboBox2.Text = b.Publisher.Name;
            if (b.Akcii != null)
                comboBox4.Text = b.Akcii.Description;
            else
                comboBox4.Text = string.Empty;
            var part = b.is_parts.ToList();
            foreach (Books bo in part)
                label11.Text += bo.Title + " ";
        }

        //кнопка Сохранить
        private void button6_Click_1(object sender, EventArgs e)
        {
            if(cur_book != null)
                Save_book(cur_book);
        }

        //кнопка удалить
        private void button9_Click(object sender, EventArgs e)
        {
            if (cur_book != null)
                db.BooksSet.Remove(cur_book);
            db.SaveChanges();
            ls_update();
        }

        //кнопка связать части
        private void button11_Click(object sender, EventArgs e)
        {
            if (cur_book != null)
            {
                var books = from a in db.BooksSet
                            where a.Title == comboBox3.Text
                            select a;

                if (books.Count() > 0)//
                {
                    Books books_part = books.FirstOrDefault();
                    cur_book.parts.Add(books_part);
                    books_part.is_parts.Add(cur_book);
                    db.SaveChanges();
                }
                else
                {
                    MessageBox.Show("Не получается привязать книгу");
                }
            }
            else
            {
                MessageBox.Show("Выберете книгу");
            }
        }

        //кнопка пользователи
        private void button4_Click(object sender, EventArgs e)
        {
            Form2 form = new Form2(db, 0);
            form.Show();
        }

        //кнопка Авторы
        private void button3_Click(object sender, EventArgs e)
        {
            Form2 form = new Form2(db, 1);
            form.Show();
        }

        //кнопка ИЗдательства
        private void button8_Click(object sender, EventArgs e)
        {
            Form2 form = new Form2(db, 2);
            form.Show();
        }

        //кнопка Жанры
        private void button7_Click(object sender, EventArgs e)
        {
            Form2 form = new Form2(db, 3);
            form.Show();
        }

        //кнопка приход/списание
        private void button10_Click(object sender, EventArgs e)
        {
            From_book_sell F = new From_book_sell(db);
            F.Show();
        }

        //выбор связанный частей книги
        private void comboBox3_Click(object sender, EventArgs e)
        {
            if (cur_book != null)
            {
                comboBox3.Items.Clear();
                var all_b = db.BooksSet.ToList();
                foreach (var i in all_b)
                {
                    comboBox3.Items.Add(i.Title);
                }
            }
        }
         //кнопка акции
        private void button2_Click(object sender, EventArgs e)
        {
            Form_akcii A = new Form_akcii(db);
            A.Show();   
        }

        //кнопка Продажа
        private void button1_Click(object sender, EventArgs e)
        {
            Form_Sell form_Sell = new Form_Sell(db);
            form_Sell.Show();
        }
        
        //выбор акции
        private void comboBox4_Click(object sender, EventArgs e)
        {
            comboBox4.Items.Clear();
            var akc = db.AkciiSet.ToList();
            foreach (var i in akc)
            {
                comboBox4.Items.Add(i.Description);
            }
        }
    }
}
