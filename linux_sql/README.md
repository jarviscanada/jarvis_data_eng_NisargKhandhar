# Cluster monitoring project(Introduction):
In our cluster monitoring project, we embarked on a comprehensive journey to streamline the process of monitoring hardware and usage specifications within a Google Cloud environment. Our project began with the creation of a dedicated Google Cloud instance, equipped with a Linux CentOS operating system. To facilitate remote access and management, we integrated VNC Viewer into our setup.
To kickstart our development process, we leveraged IntelliJ Studio, a powerful integrated development environment, and downloaded it onto our instance. This served as the foundation for our coding efforts.

# Quick Start
Start a psql instance using psql_docker.sh
Create tables using ddl.sql
Insert hardware specs data into the DB using host_info.sh 
Insert hardware usage data into the DB using host_usage.sh
Crontab setup

# Implementation
Basically starting the docker and postgres and running the host_usage and host_info scripts and adding all the data to the database.
Within this repository, we meticulously organized our work across three branches:
1.Feature Branch This branch became the home for all code-related activities, where we collectively added and fine-tuned various features.
2.Develop Branch Here, we curated the main changes and refinements to our codebase, ensuring that it was stable and met our project's core requirements.
3.Master Branch  Our master branch served as the pinnacle of our project, housing the most polished and production-ready code.

# Scripts 
Implemented host_info.sh file to get all the hardware specifications:
Implemented host_usage.sh file to get all the computer specifications:
Implemented ddl.sql file
Employed docker and postgresql and created a database host_agent.
Created 2 tables with all the columns up and connected the database table

# Database Modelling
As part of our data management strategy, we employed Docker and PostgreSQL to create a robust database capable of storing extensive hardware and usage specification data. This infrastructure laid the groundwork for our data-driven monitoring system. 
To gather essential hardware and usage specifications, we ingeniously integrated bash scripts into IntelliJ Studio. These scripts allowed us to collect crucial data from the cluster environment seamlessly.
host_usage table has different columns as follows:

| COLUMN NAME     | DATA TYPE        |
|-----------------| -----------------|
| memory_free     |  INT4 NOT NULL   |
| cpu_idle        |  INT4 NOT NULL   |
| cpu_kernel      |  INT4 NOT NULL   |
| disk_io         |  INT4 NOT NULL   |
| disk_available  |  INT4 NOT NULL   |

host_info table has different columns as follows:

| COLUMN NAME     | DATA TYPE        |
|-----------------| -----------------|
| hostname        | VARCHAR NOT NULL |
| cpu_number      | INT2 NOT NULL    |
| cpu_architecture| VARCHAR NOT NULL |
| cpu_model       | VARCHAR NOT NULL |
| cpu_mhz         | FLOAT8 NOT NULL  |
| l2_cache        | INT4 NOT NULL    |
| timestamp       | TIMESTAMP NULL   |
| total_mem       | INT4 NULL        |

# Deployment 
Deployed the Dockerized application on the Google Cloud instance.
Set up PostgreSQL to efficiently manage the database for hardware and usage data.

# Improvements & Achievements
One of the standout features of our project was our implementation of crontab. This tool enabled us to fetch real-time data at scheduled intervals, ensuring that our monitoring system provided up-to-the-minute insights into the cluster's health and performance.
To ensure the project's transparency and accessibility, we diligently uploaded the entire codebase, along with relevant documentation, to our GitHub repository. This not only facilitated seamless collaboration but also showcased our commitment to open-source principles.
In summary, our cluster monitoring project was a testament to our skills in cloud computing, database management, coding, and project collaboration. It underscored our ability to create a robust monitoring solution within a cloud environment and showcased our commitment to best practices in software development and version control.
