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
        Books cur_book;
        Users users; // пользователь для откладывания книг
        Model1Container db;
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

            //проверяем есть ли уже такой автор
            Authors author = new Authors();
            author.Name = textBox2.Text;
            var au = db.AuthorsSet.ToList();
            if (au.Contains(author))
            {
                //если есть - ставим его в авторы книги
                author.Books.Add(book);
                book.Authors = author;
            }
            else
            {
                //если такого автора нет - делаем нового
                db.AuthorsSet.Add(author);
                book.Authors = author;
                author.Books.Add(book);
            }
        }
            
            //приходится связывать пользователя и книгу здесь.
            //users = db.UsersSet.Where(u => u.Iduser == current_user.Id).First();
            //book.Users = users;
            //users.Books.Add(book);
        

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
                    Books book = new Books();
                    Save_book(book);
                    
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
            textBox1.Text = b.Title;
            textBox2.Text = b.Authors.Name;
            textBox3.Text = b.Year.ToString();
            textBox4.Text = b.Cost.ToString();
            textBox5.Text = b.Cost_self.ToString();
            textBox6.Text = b.Pages.ToString();
            comboBox1.Text = b.Genre.Name;
            comboBox2.Text = b.Publisher.Name;
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
    }
}
