var menudata = {
    'my': {
        'text': '基础信息',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'welcome': {
                'text': '基础信息管理',
                'powerid': '1',
                'children': {
                    'head': {
                        'text': '首页',
                        'url': '/suggest/homepage.jsp'
                    },
                    'representative': {
                        'text': '代表管理',
                        'url': '/delegate/list.jsp',
                        'powerid': '2',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'append': {
                                'text': '新增代表',
                            },
                            'edit': {
                                'text': '编辑代表',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'import': {
                                'text': '导入',
                            },
                            'butreports': {
                                'text': '报表',
                            }
                        }
                    },
                    'delegation': {
                        'text': '代表团管理',
                        'url': '/delegation/list.jsp',
                        'powerid': '3',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'append': {
                                'text': '新增代表团',
                            },
                            'edit': {
                                'text': '编辑代表团',
                            },
                            'delete': {
                                'text': '删除',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butreports': {
                                'text': '报表',
                            }
                        }
                    },
                    'company': {
                        'text': '单位管理',
                        'url': '/company/list.jsp',
                        'powerid': '4',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'append': {
                                'text': '新增单位',
                            },
                            'edit': {
                                'text': '编辑单位',
                            },
                            'delete': {
                                'text': '删除',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butreports': {
                                'text': '报表',
                            }
                        }
                    },
                    'companyuser': {
                        'text': '工作人员',
                        'powerid': '5',
                        'url': '/company/companyuser/list.jsp',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'append': {
                                'text': '新增单位',
                            },
                            'edit': {
                                'text': '编辑单位',
                            },
                            'delete': {
                                'text': '删除',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butreports': {
                                'text': '报表',
                            }
                        }
                    },
                }
            },
            'recharge': {
                'text': '系统管理',
                'powerid': '6',
                'children': {
                    'staff': {
                        'text': '用户管理',
                        'url': '/staff/list.jsp',
                        'powerid': '7',
                    },
                    'power': {
                        'text': '资源管理',
                        'url': '/staff/resources/list.jsp',
                        'powerid': '8',
                    },
                    'group': {
                        'text': '角色管理',
                        'url': '/staff/power/group/list.jsp',
                        'powerid': '9',
                    },
                    'position': {
                        'text': '日志管理',
                        'url': '/staff/position/list.jsp',
                        'powerid': '10',
                    },
                    'department': {
                        'text': '用户组',
                        'url': '/staff/department/list.jsp',
                        'powerid': '11',
                    }
                }
            },
            'settings': {
                'text': '设置管理',
                'powerid': '12',
                'children': {
                    'code': {
                        'text': '代码管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '13',
                    },
                    'dictionary': {
                        'text': '字典管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '14',
                    },
                    'timer': {
                        'text': '届次管理',
                        'url': '/setup/session/list.jsp',
                        'powerid': '15',
                    },
                    'conf': {
                        'text': '配置管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '16',
                    },
                    'statistics': {
                        'text': '统计管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '17',
                    },
                    'reports': {
                        'text': '报表管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '18',
                    },
                    'version': {
                        'text': '版本',
                        'powerid': '19',
                        'url': '/version/list.jsp'
                    }
                }
            }
        }
    },
    'top2': {
        'text': '履职管理',
        'powerid': '20',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'consult1': {
                'text': '知情知政',
                'powerid': '21',
                'children': {
                    'notice': {
                        'text': '最新资讯',
                        'url': '/newinformation/list.jsp',
                    }
                }
            },
            'consult2': {
                'text': '履职等级',
                'powerid': '22',
                'children': {
                }
            },
            'consult3': {
                'text': '履职交流',
                'powerid': '23',
                'children': {
                }
            },
            'consult': {
                'text': '代表评价',
                'powerid': '24',
                'children': {
                    'submit': {
                        'text': '提交征询意见',
                        'url': '/opinion/see.jsp',
                        'powerid': '25',
                    },
                    'monitor': {
                        'text': '意见征询情况',
                        'url': '/opinion/look.jsp',
                        'powerid': '26',
                    }
                }
            },
            'consult4': {
                'text': '法规意见征询',
                'powerid': '27',
                'children': {
                }
            },
            'consult5': {
                'text': '履职列表',
                'powerid': '28',
                'children': {
                    'notice': {
                        'text': '履职详情',
                        'url': '/lvzhilist/list.jsp',
                    }
                }
            },
            'consult6': {
                'text': '评分规则',
                'powerid': '29',
                'children': {
                    'notice': {
                        'text': '详情规则',
                        'url': '/scoringrules/list.jsp',
                    }
                }
            },
            'consult7': {
                'text': '代表活动',
                'powerid': '30',
                'children': {
                    'notice1': {
                        'text': '我的活动',
                        'powerid': '31',
                        'url': '/activities/myactivities/list.jsp',
                    },
                    'notice2': {
                        'text': '发起活动',
                        'powerid': '32',
                        'url': '/activities/start/list.jsp',
                    },
                    'notice3': {
                        'text': '活动报名中',
                        'powerid': '33',
                        'url': '/activities/sign/list.jsp',
                    },
                    'notice4': {
                        'text': '活动进行中',
                        'powerid': '34',
                        'url': '/activities/ongoing/list.jsp',
                    },
                    'notice5': {
                        'text': '活动成果总结',
                        'powerid': '35',
                        'url': '/activities/summary/list.jsp',
                    },
                    'notice6': {
                        'text': '活动管理',
                        'powerid': '36',
                        'url': '/activities/admin/list.jsp',
                    }
                }
            }
        }
    }, 'top3': {
        'text': '议案建议',
        'powerid': '37',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'guanli': {
                'text': "议案建议管理",
                'powerid': '38',
                'children': {
                    'suggest': {
                        'text': '建议管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '39',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'supersearch': {
                                'text': '高级查询',
                            },
                            'append': {
                                'text': '新增建议',
                            },
                            'edit': {
                                'text': '编辑建议',
                            },
                            'butreview': {
                                'text': '审查',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butimportance': {
                                'text': '重点建议',
                            },
                            'butexcellent': {
                                'text': '优秀建议',
                            },
                            'butreports': {
                                'text': '报表',
                            }
                        }
                    },
                    'motion': {
                        'text': '议案管理',
                        'url': '/billlist/list.jsp',
                        'powerid': '40',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'supersearch': {
                                'text': '高级查询',
                            },
                            'append': {
                                'text': '新增议案',
                            },
                            'edit': {
                                'text': '编辑议案',
                            },
                            'butreview': {
                                'text': '审查',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butimportance': {
                                'text': '重点议案',
                            },
                            'butexcellent': {
                                'text': '优秀议案',
                            },
                            'butreports': {
                                'text': '报表',
                            }
                        }
                    },
                }
            },
            'motionsubmit': {
                'text': '议案建议提交',
                'powerid': '41',
                'children': {
                    'motionadd': {
                        'text': '新增议案建议',
                        'url': '/bill/edit.jsp',
                        'powerid': '42',
                    },
                    'situation': {
                        'text': '信息提交情况',
                        'url': '/bill/see.jsp',
                        'powerid': '43',
                    }
                }
            },
            'review': {
                'text': '议案建议审查',
                'powerid': '44',
                'children': {
                    'situation': {
                        'text': '审查情况',
                        'url': '/examine/see.jsp',
                        'powerid': '45',
                    },
                    'processing': {
                        'text': '审查处理',
                        'url': '/examine/handle.jsp',
                        'powerid': '46',
                    }
                }
            },
            'handle': {
                'text': '议案建议办理',
                'powerid': '47',
                'children': {
                    'company': {
                        'text': '确定办理单位',
                        'url': '/handle/confirm/see.jsp',
                        'powerid': '48',
                    },
                    'submit': {
                        'text': '议案建议交办',
                        'url': '/handle/assign/look.jsp',
                        'powerid': '49',
                    },
                    'reply': {
                        'text': '议案建议办复',
                        'url': '/handle/resume/resume.jsp',
                        'powerid': '50',
                    },
                    'monitor': {
                        'text': '办理进度监控',
                        'url': '/handle/company.jsp',
                        'powerid': '51',
                    },
                    'report': {
                        'text': '办理总结报告',
                        'url': '/handle/summary/list.jsp',
                        'powerid': '52',
                    }
                }
            },
            'consult1': {
                'text': '我领衔的议案建议',
                'powerid': '53',
                'children': {
                    'report': {
                        'text': '我领衔的议案建议列表',
                        'url': '/mysuggest/list.jsp',
                    }
                }
            },
            'consult2': {
                'text': '我联名的议案建议',
                'powerid': '54',
                'children': {
                    'report': {
                        'text': '我联名的议案建议列表',
                        'url': '/secsuggest/list.jsp',
                    }
                }
            },
            'consult3': {
                'text': '草稿箱议案建议',
                'powerid': '55',
                'children': {
                    'report': {
                        'text': '草稿箱的议案建议列表',
                        'url': '/drsuggest/list.jsp',
                    }
                }
            },
            'consult4': {
                'text': '不予接收建议',
                'powerid': '56',
                'children': {
                }
            },
            'consult5': {
                'text': '申请退回建议',
                'powerid': '57',
                'children': {
                }
            },
            'consult6': {
                'text': '申请延期建议',
                'powerid': '58',
                'children': {
                }
            },
            'consult7': {
                'text': '对口联系专委会建议',
                'powerid': '59',
                'children': {
                }
            },
            'statistics': {
                'text': '信息统计分析',
                'powerid': '60',
                'children': {
                    'company': {
                        'text': '议案建议统计',
                        'url': '/statistics/suggest/proposal.jsp',
                        'powerid': '61',
                    },
                    'submit': {
                        'text': '代表信息统计',
                        'url': '/statistics/proposal.jsp',
                        'powerid': '62',
                    },
                    'reply': {
                        'text': '代表建议统计',
                        'url': '/statistics/proposal.jsp',
                        'powerid': '63',
                    },
                    'monitor': {
                        'text': '建议办理统计',
                        'url': '/statistics/proposal.jsp',
                        'powerid': '64',
                    }
                }
            },
            'inquire': {
                'text': '信息综合查询',
                'powerid': '65',
                'children': {
                    'company': {
                        'text': '建议信息',
                        'url': '/query/suggest/list.jsp',
                        'powerid': '66',
                    },
                    'submit': {
                        'text': '议案信息',
                        'url': '/query/billlist/list.jsp',
                        'powerid': '67',
                    },
                    'reply': {
                        'text': '代表信息',
                        'url': '/query/delegate/list.jsp',
                        'powerid': '68',
                    },
                    'monitor': {
                        'text': '单位信息',
                        'url': '/query/company/list.jsp',
                        'powerid': '69',
                    }
                }
            },
        }
    }, 'top4': {
        'text': '学习培训',
        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "学习课件",
                'powerid': '71',
                'children': {
                }
            },
            'menutop2': {
                'text': "专题讲座",
                'powerid': '72',
                'children': {
                }
            },
            'menutop3': {
                'text': "法律法规",
                'powerid': '73',
                'children': {
                }
            },
            'menutop4': {
                'text': "履职参考",
                'powerid': '74',
                'children': {
                }
            }
        }
    }, 'top5': {
        'text': '工作交流',
        'powerid': '75',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "通知公告",
                'powerid': '76',
                'children': {
                    'notice': {
                        'text': '通知公告列表',
                        'url': '/notice/list.jsp',
                    }
                }
            },
            'menutop2': {
                'text': "短信平台",
                'powerid': '77',
                'children': {
                }
            },
            'menutop3': {
                'text': "实时邮箱",
                'powerid': '78',
                'children': {
                }
            },
            'menutop4': {
                'text': "内部消息",
                'powerid': '79',
                'children': {
                }
            }
        }
    },
    'top6': {
        'text': '双联服务',
        'powerid': '80',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "网上代表联络站",
                'powerid': '81',
                'children': {
                }
            },
        }
    },
    'top7': {
        'text': '代表网',
        'powerid': '82',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "工作动态",
                'powerid': '83',
                'children': {
                }
            },
            'menutop2': {
                'text': "人大代表制度",
                'powerid': '84',
                'children': {
                }
            },
            'menutop3': {
                'text': "人大代表信息查看",
                'powerid': '85',
                'children': {
                }
            }
        }
    },
    'top8': {
        'text': '社情民意',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                },
            },
            'menutop1': {
                'text': "社情民意",
                'powerid': '86',
                'children': {
                    'notice': {
                        'text': '社情民意信息',
                        'url': '/poll/list.jsp',
                        'powerid': '87',
                    }
                }
            },
        }
    },
    'top9': {
        'text': '建议点评',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "建议点评",
                'powerid': '88',
                'children': {
                    'notice': {
                        'text': '点评信息',
                        'url': '/poll/list.jsp',
                    }
                }
            },
        }
    },
    'top10': {
        'text': '建议线索',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "建议线索",
                'powerid': '89',
                'children': {
                    'notice': {
                        'text': '线索信息',
                        'url': '/suggest/clue/list.jsp',
                    }
                }
            },
        }
    },
     'top11': {
        'text': '人大监督',
        'powerid': '90',
        'children': {
            'menutop': {
                'text': "功能导航111",
                'children': {
                }
            },
            'menutop1': {
                'text': "工作动态111",
                'powerid': '83',
                'children': {
                }
            },
            'menutop2': {
                'text': "人大代表制度111",
                'powerid': '84',
                'children': {
                }
            },
            'menutop3': {
                'text': "人大代表信息查看111",
                'powerid': '85',
                'children': {
                }
            }
        }
    },
}