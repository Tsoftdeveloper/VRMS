# Generated by Django 3.2 on 2023-03-22 16:49

import django.core.validators
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='Contact_Number',
            field=models.CharField(max_length=100, validators=[django.core.validators.RegexValidator(message='Invalid number', regex='^((\\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})$')]),
        ),
    ]