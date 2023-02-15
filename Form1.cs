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
        Users users; // 
        public Form1()
        {
            InitializeComponent();
        }

        //обновление листбокса
        public void ls_update()
        {
            using (Model1Container db = new Model1Container())
            {
                var books = db.BooksSet.ToList();
                listBox1.Items.Clear();
                foreach (var book in books)
                    listBox1.Items.Add(book.Title);
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
            ls_update();
        }

        //кнопка Новая книга
        private void button5_Click(object sender, EventArgs e)
        {
            if (textBox1.Text.Length < 1 || textBox2.Text.Length < 1)
                MessageBox.Show("Все поля должны быть заполнены");
            else
            {
                //try // Прости, Господи
                {
                    using (Model1Container db = new Model1Container())
                    {
                        Books book = new Books();
                        book.Title = textBox1.Text;
                        book.Year = Convert.ToInt32(textBox3.Text);
                        book.Cost = Convert.ToInt32(textBox4.Text);
                        //выбор жанра
                        Genre g = db.GenreSet.Where(ge => ge.Name == comboBox1.Text).FirstOrDefault();
                        book.Genre = g;
                        g.Books.Add(book);
                        //проверяем есть ли уже такой автор
                        var au = db.AuthorsSet.ToList();
                        foreach (Authors a in au)
                        {
                            if (a.Name == textBox2.Text)
                            {
                                //если есть - ставим его в авторы книги
                                a.Books.Add(book);
                                book.Authors.Add(a);
                            }
                            else
                            {
                                //если такого автора нет - делаем нового
                                Authors author = new Authors();
                                author.Name = textBox2.Text;
                                db.AuthorsSet.Add(author);
                                author.Books.Add(book);
                                book.Authors.Add(author);
                            }
                        }
                        //приходится связывать пользователя и книгу здесь.
                        users = db.UsersSet.Where(u => u.Iduser == current_user.Id).First();
                        book.Users = users;
                        users.Books.Add(book);
                        db.BooksSet.Add(book);
                        db.SaveChanges();
                        ls_update();
                    }
                }
                //catch (Exception ex)
                {
                    //MessageBox.Show(ex.Message);
                }
            }
        }

        //Забронировать
        private void button6_Click(object sender, EventArgs e)
        {

        }

        //открытие списка жанров
        private void comboBox1_Click(object sender, EventArgs e)
        {
            using (Model1Container db = new Model1Container())
            {
                comboBox1.Items.Clear();
                var Geners = db.GenreSet.ToList();
                foreach (var i in Geners)
                {
                    comboBox1.Items.Add(i.Name);
                }
            }
        }
    }
}
