﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exam_ADO
{
    public class User
    {
        public int Id { get; set; } // номер, соответствует id в БД
        public string username { get; set; } // имя
        public string password { get; set; } // имя
        public string name { get; set; } // имя
        public string surname { get; set; } // фамилия
        public DateTime create_time { get; set; }

        public override string ToString()
        {
            return name + " " + surname;
        }
    }
}
