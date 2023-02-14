using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Data.Sqlite;
using System.Windows.Forms;

namespace Exam_ADO
{
    /// <summary>
    /// класс, осуществляющий вход в систему
    /// </summary>
    internal class Logger
    {
        /// <summary>
        /// Вход в систему
        /// </summary>
        /// <param name="username"></param>
        /// <param name="pass"></param>
        /// <returns>Новый объект User</returns>
        internal User Login(string username, string pass)
        {
                // Создание подключения
                using (SqliteConnection connection = new SqliteConnection("Data source = filesdata.db"))
                {
                    SqliteCommand command = new SqliteCommand($@"SELECT * from users WHERE username = '{username}' and password = '{pass}'", connection);
                    connection.Open();
                    SqliteDataReader sqldatareader = command.ExecuteReader();
                    if (sqldatareader.HasRows)
                    {
                        User user = new User();
                        while (sqldatareader.Read())
                        {
                            user.Id = sqldatareader.GetInt32(0);
                            user.name = sqldatareader.GetString(3);
                            user.surname = sqldatareader.GetString(4);
                        }
                        sqldatareader.Close();
                        return user;
                    }
                    else
                        return null;
                }
        }
    }
}